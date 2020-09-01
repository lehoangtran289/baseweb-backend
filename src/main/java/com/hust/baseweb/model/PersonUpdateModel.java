package com.hust.baseweb.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PersonUpdateModel {
    private String firstName;
    private String lastName;
    private String middleName;
    private Date birthDate;
    private String partyCode;
    private List<String> roles;
}
