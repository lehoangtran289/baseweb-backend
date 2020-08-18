package com.hust.baseweb.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.Date;
import java.util.Set;

@Entity
@Getter
@Setter
public class UserLogin {
    public static final PasswordEncoder PASSWORD_ENCODER = new BCryptPasswordEncoder();

    @Id
    @Column(name = "user_login_id", updatable = false, nullable = false)
    private String userLoginId;

    @Column(name = "current_password")
    private String password;

    private String passwordHint;

    @Email
    private String email;

    private String otpSecret;

    private boolean isSystem;

    private boolean enabled;

    private boolean hasLoggedOut;

    private boolean requirePasswordChange;

    private Integer successiveFailedLogins;

    private String clientToken;

    private int otpResendNumber;

    @JoinColumn(name = "party_id", referencedColumnName = "party_id")
    @OneToOne(fetch = FetchType.EAGER)
    private Party party;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "user_login_security_group", joinColumns = @JoinColumn(name = "user_login_id",
            referencedColumnName = "user_login_id"),
            inverseJoinColumns = @JoinColumn(name = "group_id", referencedColumnName = "group_id"))
    private Set<SecurityGroup> roles;

    private Date disabledDateTime;

    // -----------------------------------

    public UserLogin() {
    }

    public UserLogin(String userLoginId, String password, boolean enabled, Set<SecurityGroup> roles) {
        this.userLoginId = userLoginId;
        this.password = password;
        this.enabled = enabled;
        this.roles = roles;
    }

    public UserLogin(String password, String passwordHint, boolean isSystem, boolean enabled,
                     boolean hasLoggedOut, boolean requirePasswordChange, Integer successiveFailedLogins,
                     Date disabledDateTime) {
        super();
        this.password = password;
        this.passwordHint = passwordHint;
        this.isSystem = isSystem;
        this.enabled = enabled;
        this.hasLoggedOut = hasLoggedOut;
        this.requirePasswordChange = requirePasswordChange;
        this.successiveFailedLogins = successiveFailedLogins;
        this.disabledDateTime = disabledDateTime;
    }


}
