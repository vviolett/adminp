package adminp.repos;

import adminp.domain.Project;
import org.springframework.data.repository.CrudRepository;

public interface ProjectRepo extends CrudRepository<Project, Long> {
    Project findById(Integer projectId);
}
