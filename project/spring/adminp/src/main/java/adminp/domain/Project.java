package adminp.domain;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "project")
public class Project {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private String text;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_projects",
            joinColumns = { @JoinColumn(name = "project_id")},
            inverseJoinColumns = { @JoinColumn(name = "user_id")}
    )
    private Set<User> projectUsers = new HashSet<>();

    @OneToMany(mappedBy = "project", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Task> tasks;

    public Project(){

    }

    public Project(String text){
        this.text = text;
    }

    public Integer countTasks(){
        return tasks.size();
    }

    public Set<Task> getTasks() {
        return tasks;
    }

    public void setTasks(Set<Task> tasks) {
        this.tasks = tasks;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Transactional
    public Set<User> getProjectUsers() {
        return projectUsers;
    }

    @Transactional
    public void setProjectUsers(Set<User> projectUsers) {
        this.projectUsers = projectUsers;
    }
}
