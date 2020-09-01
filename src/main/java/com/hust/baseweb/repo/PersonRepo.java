package com.hust.baseweb.repo;

import com.hust.baseweb.entity.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@RepositoryRestResource(exported = false)
public interface PersonRepo extends JpaRepository<Person, UUID> {
    Person findByPartyId(UUID partyId);
}
