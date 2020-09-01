package com.hust.baseweb.rest.user;

import com.hust.baseweb.entity.Person;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.rest.core.config.Projection;

@Projection(name = "PersonProjection", types = {Person.class})
public interface PersonProjection {

    @Value("#{target.firstName} #{target.lastName}")
    String getFullName();
}
