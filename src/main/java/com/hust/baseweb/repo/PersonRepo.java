package com.hust.baseweb.repo;

import com.hust.baseweb.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PersonRepo extends JpaRepository<Person, UUID> {
    Person findByPartyId(UUID partyId);
}
