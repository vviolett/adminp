package adminp.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER, ADMIN, PM;

    @Override
    public String getAuthority() {
        return name();
    }
}
