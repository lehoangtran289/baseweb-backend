package com.hust.baseweb.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.Date;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Party {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "party_id")
    private UUID partyId;

    private String partyCode;

    @JoinColumn(name = "party_type_id", referencedColumnName = "party_type_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private PartyType type;

    @Column(columnDefinition = "TEXT")
    private String description;

    @JoinColumn(name = "status_id", referencedColumnName = "status_id")
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Status partyStatus;

    @JoinColumn(name = "party_id", referencedColumnName = "party_id")
    @OneToOne(fetch = FetchType.EAGER, mappedBy = "party")
    private UserLogin userLogin;

    private boolean isUnread;

    @CreatedDate
    private Date createdDate;

    @LastModifiedDate
    private Date lastModifiedDate;

    @Column(name = "created_by_user_login")
    @CreatedBy
    private String createdBy;

    @Column(name = "last_modified_by_user_login")
    @LastModifiedBy
    private String modifiedBy;

    // create username show in party list
    @Transient
    private String userName;

    // create partyname show in party list; party = person.firstname +
    // person.middlename + person.lastname
    @Transient
    private String partyName;

    @Transient
    private Person person;

    public Party(String partyCode, PartyType type, String description, Status partyStatus, boolean isUnread) {
        super();
        this.partyCode = partyCode;
        this.type = type;
        this.description = description;
        this.partyStatus = partyStatus;
        this.isUnread = isUnread;
    }

}
