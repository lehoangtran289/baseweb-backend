package com.hust.baseweb.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
public class SecurityGroup {
    @Id
    @Column(name = "group_id")
    private String groupId;

    private String description;

    @JoinTable(name = "security_group_permission", joinColumns = @JoinColumn(name = "group_id",
            referencedColumnName = "group_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id", referencedColumnName = "permission_id"))
    @OneToMany(fetch = FetchType.LAZY)
    private List<SecurityPermission> permissions;

    private Date createdStamp;

    private Date lastUpdatedStamp;

    // -----------------------------------

    public SecurityGroup() {
    }

}
