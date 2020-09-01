package com.hust.baseweb.service;

import com.hust.baseweb.entity.*;
import com.hust.baseweb.model.PersonModel;
import com.hust.baseweb.model.PersonUpdateModel;
import com.hust.baseweb.repo.*;
import com.hust.baseweb.rest.user.DPerson;
import com.hust.baseweb.rest.user.UserRestBriefProjection;
import com.hust.baseweb.rest.user.UserRestRepository;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityExistsException;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.UUID;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
@Transactional
@Log4j2
public class UserServiceImpl implements UserService {

    public static final String module = UserService.class.getName();
    private final PartyTypeRepo partyTypeRepo;
    private final PartyRepo partyRepo;
    private final StatusRepo statusRepo;
    private final PersonRepo personRepo;
    private final SecurityGroupRepo securityGroupRepo;
    private UserLoginRepo userLoginRepo;
    private UserRestRepository userRestRepository;
    private PartyService partyService;

    @Override
    public UserLogin findById(String userLoginId) {
        return userLoginRepo.findByUserLoginId(userLoginId);
    }

    @Override
    public DPerson findByPartyId(String parytyId) {
        return userRestRepository.findById(UUID.fromString(parytyId)).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public Page<UserRestBriefProjection> findPersonByFullName(Pageable page, String sString) {
        return null;
    }

    @Override
    public List<UserLogin> getAllUserLogins() {
        return userLoginRepo.findAll();
    }

    @Override
    @Transactional
    public UserLogin createAndSaveUserLogin(String userName, String password) {
        Party party = partyService.save(PartyType.PartyTypeEnum.PERSON.name());
        UserLogin userLogin = new UserLogin(userName, password, true, null);
        userLogin.setParty(party);

        if (userLoginRepo.existsById(userName))
            throw new EntityExistsException("userLoginId = " + userLogin.getUserLoginId() + " existed!");

        return userLoginRepo.save(userLogin);
    }

    @Override
    public UserLogin updatePassword(UserLogin user, String password) {
        user.setPassword(password);
        return userLoginRepo.save(user);
    }

    @Override
    public Party createAndSaveUserLogin(PersonModel personModel) throws Exception {
        Party party = new Party(personModel.getPartyCode(),
                partyTypeRepo.getOne(PartyType.PartyTypeEnum.PERSON.name()), "",
                statusRepo
                        .findById(Status.StatusEnum.PARTY_ENABLED.name())
                        .orElseThrow(NoSuchElementException::new),
                false);
        party = partyRepo.save(party);
        personRepo.save(new Person(party.getPartyId(), personModel.getFirstName(), personModel.getMiddleName(),
                personModel.getLastName(), personModel.getGender(), personModel.getBirthDate()));

        Set<SecurityGroup> roles = securityGroupRepo.findAllByGroupIdIn(personModel.getRoles());

        log.info("save, roles = " + personModel.getRoles().size());

        UserLogin userLogin = new UserLogin(personModel.getUserName(), personModel.getPassword(), true, roles);
        userLogin.setParty(party);
        if (userLoginRepo.existsById(personModel.getUserName())) {
            throw new RuntimeException();
        }
        userLoginRepo.save(userLogin);
        return party;
    }

    @Override
    public Party update(PersonUpdateModel personUpdateModel, UUID partyId) {
        Person person = personRepo.getOne(partyId);
        person.setBirthDate(personUpdateModel.getBirthDate());
        person.setFirstName(personUpdateModel.getFirstName());
        person.setLastName(personUpdateModel.getLastName());
        person.setMiddleName(personUpdateModel.getMiddleName());
        personRepo.save(person);

        Party party = partyRepo.getOne(partyId);
        party.setPartyCode(personUpdateModel.getPartyCode());
        UserLogin u = party.getUserLogin();

        u.setRoles(securityGroupRepo.findAllByGroupIdIn(personUpdateModel.getRoles()));

        userLoginRepo.save(u);
        return partyRepo.findById(person.getPartyId()).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public UserLogin findUserLoginByPartyId(UUID partyId) {
        Party party = partyService.findByPartyId(partyId);
        return userLoginRepo.findByParty(party).get(0);
    }
}
