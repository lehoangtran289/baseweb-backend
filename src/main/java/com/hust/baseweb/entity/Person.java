package com.hust.baseweb.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Person {
    @Id
    @Column(name = "party_id")
    private UUID partyId;

    private String firstName;

    private String middleName;

    private String lastName;

    private String gender;

    private Date birthDate;

    @Transient
    private String name;

    @Transient
    private String userName;

    // -----------------------------------

    public Person(UUID partyId, String firstName, String middleName, String lastName, String gender,
                  Date birthDate) {
        this.partyId = partyId;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.gender = gender;
        this.birthDate = birthDate;
    }

    public BasicInfoModel getBasicInfoModel() {
        return new BasicInfoModel(partyId, firstName + " " + middleName + " " + lastName, gender);
    }

    @Override
    public String toString() {
        return "Person{" +
                "partyId=" + partyId +
                ", firstName='" + firstName + '\'' +
                ", middleName='" + middleName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", gender='" + gender + '\'' +
                ", birthDate=" + birthDate +
                ", name='" + name + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }

    @Getter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class BasicInfoModel {
        private UUID partyId;
        private String fullName;
        private String gender;

    }
}
