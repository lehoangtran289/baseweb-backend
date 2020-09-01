package com.hust.baseweb.rest.user;

import com.hust.baseweb.entity.PartyType;
import com.hust.baseweb.entity.Person;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.rest.core.config.Projection;

import java.util.Date;

@Projection(name = "brief", types = {DPerson.class})
public interface UserRestBriefProjection {
    String getPartyCode();

    PersonProjection getPerson();

    UserLoginProjection getUserLogin();

    @Value("#{target.createdDate}")
    Date getCreatedDate();

    PartyTypeProjection getPartyType();

    String getStatus();

    String getPartyId();
}
