package com.hust.baseweb.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Status {
    @Id
    @Column(name = "status_id")
    private String id;

    @JoinColumn(name = "status_type_id", referencedColumnName = "status_type_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private StatusType type;

    private String statusCode;

    private String sequenceId;

    private String description;

    private Date createdStamp;

    private Date lastUpdatedStamp;

    public Status(String id, StatusType type, String statusCode, String sequenceId, String description) {
        this.id = id;
        this.type = type;
        this.statusCode = statusCode;
        this.sequenceId = sequenceId;
        this.description = description;
    }

    public enum StatusEnum {
        SINGLE, MARRIED, DIVORCED, PARTY_ENABLED, PARTY_DISABLED
    }
}
