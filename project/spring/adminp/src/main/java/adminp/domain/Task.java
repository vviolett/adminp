package adminp.domain;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String text;
    private String tag;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "executor_id")
    private User executor;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    @OneToMany(mappedBy = "task", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Comment> comments;

    private LocalDate date;

    private String filename;

    private LocalTime time;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private Project project;

    @ElementCollection(targetClass = Status.class, fetch = FetchType.LAZY)
    @CollectionTable(name = "task_status", joinColumns = @JoinColumn(name = "task_id"))
    @Enumerated(EnumType.STRING)
    private List<Status> statuses = new LinkedList<>();

    @Enumerated(EnumType.STRING)
    private Priority priority;

    //Какие задачи блокирует данная задача
    @ManyToMany
    @JoinTable(name="task_block",
            joinColumns=@JoinColumn(name="task_id"),
            inverseJoinColumns=@JoinColumn(name="blocked_id")
    )
    private List<Task> blockers= new LinkedList<>();

    //Задачи которые блокируют данную задачу
    @ManyToMany
    @JoinTable(name="task_block",
            joinColumns=@JoinColumn(name="blocked_id"),
            inverseJoinColumns=@JoinColumn(name="task_id")
    )
    private List<Task> blockerOf = new LinkedList<>();

    public Task() {
    }

    public Task(String text, String tag, User user, LocalDate date, User executor, Project project) {
        this.text = text;
        this.tag = tag;
        this.author = user;
        this.date = date;
        this.executor = executor;
        this.project = project;
    }

    public boolean isBlocker(){
        return blockers.size() != 0;
    }

    public List<Task> getBlockers() {
        return blockers;
    }

    public void setBlockers(List<Task> blockers) {
        this.blockers = blockers;
    }

    public List<Task> getBlockerOf() {
        return blockerOf;
    }

    public void setBlockerOf(List<Task> blockerOf) {
        this.blockerOf = blockerOf;
    }

    public Priority getPriority() {
        return priority;
    }

    public void setPriority(Priority priority) {
        this.priority = priority;
    }

    public List<Status> getStatuses() {
        return statuses;
    }

    public void setStatuses(List<Status> statuses) {
        this.statuses = statuses;
    }

    public String getActualStatus(){
        return statuses.get(statuses.size()-1).name();
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    public User getExecutor() {
        return executor;
    }

    public void setExecutor(User executor) {
        this.executor = executor;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getAuthorName() {
        return author != null ? author.getUsername() : "<none>";
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }
}
