package com.hust.baseweb.service;

import com.hust.baseweb.entity.Person;
import com.hust.baseweb.repo.PersonRepo;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class PersonServiceImpl implements PersonService{
    private PersonRepo personRepo;

    @Override
    public Person findByPartyId(UUID partyId) {
        return personRepo.findByPartyId(partyId);
    }
}
