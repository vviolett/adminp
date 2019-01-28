package adminp.controller;

import adminp.domain.Task;
import adminp.domain.User;
import adminp.repos.TaskRepo;
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
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private TaskRepo taskRepo;

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

        return "main";
    }

    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag, Map<String, Object> model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        Task task = new Task(text, tag, user);

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

        return "parts/taskForm";
    }

    @PostMapping("/tasks/{taskId}")
    public String updateTask(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("id") Integer taskId,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
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
}
