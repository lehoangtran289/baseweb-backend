package com.hust.baseweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
public class StatusItem {
    @Id
    @Column(name = "status_id")
    private String statusId;

    @JoinColumn(name = "status_type_id", referencedColumnName = "status_type_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private StatusType statusType;

    @Column(name = "status_code")
    private String statusCode;

    @Column(name = "description")
    private String description;
}
