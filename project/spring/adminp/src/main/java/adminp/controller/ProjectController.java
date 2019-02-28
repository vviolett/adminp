package adminp.controller;

import adminp.domain.Project;
import adminp.domain.User;
import adminp.repos.ProjectRepo;
import adminp.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/projects")
public class ProjectController {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private UserRepo userRepo;

    @GetMapping
    public String userList(Model model){
        model.addAttribute("projects", projectRepo.findAll());
        return "projectList";
    }

    @PostMapping
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String tag,
            Map<String, Object> model
    ) throws IOException {
        Project project = new Project(tag);
        project.getProjectUsers().add(user);

        projectRepo.save(project);


        Iterable<Project> projects = projectRepo.findAll();

        model.put("projects", projects);

        return "projectList";
    }

    @GetMapping("{projectId}")
    public String projectEditForm(@PathVariable Integer projectId, Model model){
        Project project = projectRepo.findById(projectId);
        model.addAttribute("project", project);
        model.addAttribute("users", userRepo.findAll());
        return "projectEdit";
    }

    @PostMapping("{projectId}")
    public String projectSave(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("projectId") Integer projectId,
            @RequestParam("tag") String tag,
            @RequestParam Map<String, String> form,
            Model model){
        Project project = projectRepo.findById(projectId);
        project.setText(tag);

        Set<String> users = userRepo.findAll().stream().filter(u -> !u.getUsername().equals(currentUser.getUsername())).map(u -> u.getUsername()).collect(Collectors.toSet());

        for (String user : form.keySet()) {
            if (users.contains(user)) {
                project.getProjectUsers().add(userRepo.findByUsername(user));
            }
        }

        projectRepo.save(project);

        model.addAttribute("projects", projectRepo.findAll());
        return "projectList";
    }
}
