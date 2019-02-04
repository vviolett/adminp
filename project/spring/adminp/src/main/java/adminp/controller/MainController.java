package adminp.controller;

import adminp.domain.Comment;
import adminp.domain.Task;
import adminp.domain.User;
import adminp.repos.CommentRepo;
import adminp.repos.TaskRepo;
import adminp.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private TaskRepo taskRepo;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private CommentRepo commentRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(Model model) {
        Iterable<Task> tasks = taskRepo.findAll();

        model.addAttribute("tasks", tasks);
        model.addAttribute("users", userRepo.findAll());

        return "main";
    }

    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag,
            @RequestParam(name = "executor", required = false) Long executor,
            @RequestParam(name = "datepicker", required = false) String datepicker,
             Map<String, Object> model,
            @RequestParam(name = "file", required=false) MultipartFile file
    ) throws IOException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        LocalDate date = LocalDate.parse(datepicker, formatter);

        User ex = userRepo.getOne(executor);

        Task task = new Task(text, tag, user, date, ex);

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

        return "parts/taskForm";
    }

    @PostMapping("/tasks/{taskId}")
    public String updateTask(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("id") Integer taskId,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam(name = "executor", required = false) Long executor,
            @RequestParam(name = "datepicker", required = false) String datepicker,
            @RequestParam("file") MultipartFile file,
            @RequestParam(required=false , value = "save") String saveFlag,
            @RequestParam(required=false , value = "delete") String deleteFlag
    ) throws IOException {
        Task task = taskRepo.findById(taskId);

            if(saveFlag != null) {
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

                taskRepo.save(task);
            } else if(deleteFlag != null){
                taskRepo.delete(task);
                return "redirect:/main";
            }

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
        Comment comment = new Comment(text, task);

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
