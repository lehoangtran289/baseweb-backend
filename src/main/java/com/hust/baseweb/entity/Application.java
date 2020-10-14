package com.hust.baseweb.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Application {
    @Id
    @Column(name = "application_id")
    private String applicationId;

    @JoinColumn(name = "application_type_id", referencedColumnName = "application_type_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private ApplicationType applicationType;

    @JoinColumn(name = "module_id", referencedColumnName = "application_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private Application module;

    @JoinColumn(name = "permission_id", referencedColumnName = "permission_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private SecurityPermission securityPermission;

    private Date createdStamp;

    private Date lastUpdatedStamp;

    public Application(String applicationId, ApplicationType applicationType, Application module,
                       SecurityPermission securityPermission) {
        this.applicationId = applicationId;
        this.applicationType = applicationType;
        this.module = module;
        this.securityPermission = securityPermission;
    }
}
