package adminp.controller;

import adminp.domain.*;
import adminp.repos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
@Transactional
public class MainController {
    @Autowired
    private TaskRepo taskRepo;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private CommentRepo commentRepo;
    @Autowired
    private ProjectRepo projectRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    @Transactional
    public String main(@AuthenticationPrincipal User user,
                       @RequestParam(required = false, defaultValue = "") String filter,
                       Model model) {
        Iterable<Task> tasks = taskRepo.findAll();

        User currentUser = userRepo.findByUsername(user.getUsername());
        if (filter != null && !filter.isEmpty()) {
            tasks = taskRepo.findByTag(filter);
        } else {
            tasks = taskRepo.findAll();
        }

        model.addAttribute("tasks", tasks);
        model.addAttribute("users", userRepo.findAll());
        model.addAttribute("filter", filter);

        model.addAttribute("projects", currentUser.getUserProjects());

        return "main";
    }

    @GetMapping("/statistics")
    public String statistics(@AuthenticationPrincipal User user,Model model) {
        model.addAttribute("projects", user.getUserProjects());
        model.addAttribute("users", userRepo.findAll());
        return "statistics";
    }

    @GetMapping("/main/{projectId}")
    public String main(@AuthenticationPrincipal User user,
                       @PathVariable Integer projectId,
                       @RequestParam(required = false, defaultValue = "") String filter,
                       Model model) {
        List<Task> tasks = taskRepo.findByProjectId(projectId);

        User currentUser = userRepo.findByUsername(user.getUsername());
        if (filter != null && !filter.isEmpty()) {
           // tasks = taskRepo.findByTag(filter);
        } else {
           // tasks = taskRepo.findAll();
        }

        model.addAttribute("tasks", tasks);
        model.addAttribute("users", userRepo.findAll());
        model.addAttribute("filter", filter);
        model.addAttribute("priorities", Priority.values());

        model.addAttribute("projects", currentUser.getUserProjects());

        return "main";
    }

    @PostMapping("/main/{projectId}")
    public String add(
            @AuthenticationPrincipal User user,
            @PathVariable Integer projectId,
            @RequestParam String text,
            @RequestParam String tag,
            @RequestParam(name = "executor", required = false) Long executor,
            @RequestParam(name = "priority", required = false) String priority,
            @RequestParam(name = "datepicker", required = false) String datepicker,
             Map<String, Object> model,
            @RequestParam(required = false, defaultValue = "") String filter,
            @RequestParam(name = "file", required=false) MultipartFile file
    ) throws IOException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        LocalDate date = LocalDate.parse(datepicker, formatter);

        User ex = userRepo.getOne(executor);
        Project project = projectRepo.findById(projectId);

        Task task = new Task(text, tag, user, date, ex, project);
        task.setPriority(Priority.valueOf(priority));
        task.setTime(LocalTime.of(0, 0, 0));
        task.getStatuses().add(Status.ACTIVE);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            task.setFilename(resultFilename);
        }

        taskRepo.save(task);

        Iterable<Task> tasks = taskRepo.findAll();

        model.put("tasks", tasks);
        model.put("filter", filter);

        return "main";
    }

    @GetMapping("/user-tasks/{user}")
    public String userTasks(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Task task
    ) {
        Set<Task> tasks = user.getTasks();

        model.addAttribute("tasks", tasks);
        model.addAttribute("task", task);
        model.addAttribute("isCurrentUser", currentUser.equals(user));

        return "userTasks";
    }
    @GetMapping("/tasks/{taskId}")
    public String userTask(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Integer taskId,
            Model model
    ) {

        model.addAttribute("task", taskRepo.findById(taskId));
        model.addAttribute("users", userRepo.findAll());
        model.addAttribute("tasks", taskRepo.findAll());

        return "parts/taskForm";
    }

    @PostMapping("/tasks/{taskId}")
    public String updateTask(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("id") Integer taskId,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam(name = "time", required = false) String time,
            @RequestParam(name = "executor", required = false) Long executor,
            @RequestParam(name = "datepicker", required = false) String datepicker,
            @RequestParam("file") MultipartFile file,
            @RequestParam(required=false , value = "save") String saveFlag,
            @RequestParam(required=false , value = "delete") String deleteFlag,
            @RequestParam(required=false , value = "work") String work,
            @RequestParam(required=false , value = "resolve") String resolve,
            @RequestParam(name = "blocker", required = false) Integer blocker
    ) throws IOException {
        Task task = taskRepo.findById(taskId);

        //список задач которые блокируют данную задачу
        List<Task> blockers = task.getBlockerOf();
        blockers.add(taskRepo.findById(blocker));

        task.setBlockerOf(blockers);

        if(work != null) {
            task.getStatuses().add(Status.PROGRESS);
        }
        if(resolve != null) {
            task.getStatuses().add(Status.RESOLVED);
        }
            if(saveFlag != null) {
                if(!time.equals("")) {
                    DateTimeFormatter formatter1 = DateTimeFormatter.ISO_LOCAL_TIME;
                    LocalTime time1 = LocalTime.parse(time, formatter1);
                    task.setTime(time1);
                }

                if (!StringUtils.isEmpty(text)) {
                    task.setText(text);
                }

                if (!StringUtils.isEmpty(tag)) {
                    task.setTag(tag);
                }
                if (!StringUtils.isEmpty(datepicker)) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
                    LocalDate date = LocalDate.parse(datepicker, formatter);
                    task.setDate(date);
                }
                if (!StringUtils.isEmpty(executor)) {
                    User ex = userRepo.getOne(executor);
                    task.setExecutor(ex);
                }

                saveFile(task, file);
            } else if(deleteFlag != null){
                taskRepo.delete(task);
                return "redirect:/main";
            }
        taskRepo.save(task);

        return "redirect:/tasks/" + task.getId();
    }

    private void saveFile(@Valid Task task, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            task.setFilename(resultFilename);
        }
    }
    @PostMapping("/tasks/addComment")
    public String updateTas(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("id") Integer taskId,
            @RequestParam("text") String text,
            @RequestParam(required=false , value = "save") String saveFlag,
            @RequestParam(required=false , value = "delete") String deleteFlag
    ) throws IOException {
        Task task = taskRepo.findById(taskId);
        LocalDate date = LocalDate.now();
        Comment comment = new Comment(text, task, currentUser, date);

        task.getComments().add(comment);
        commentRepo.save(comment);

        if(saveFlag != null) {
            taskRepo.save(task);
        } else if(deleteFlag != null){
            taskRepo.delete(task);
            return "redirect:/main";
        }

        return "redirect:/tasks/" + task.getId();
    }
}
