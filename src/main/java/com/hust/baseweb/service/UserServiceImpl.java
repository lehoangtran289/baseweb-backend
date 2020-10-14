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
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
@Transactional
@Log4j2
public class UserServiceImpl implements UserService {

    public static final String module = UserService.class.getName();
    private final PartyTypeRepo partyTypeRepo;
    private final PartyRepo partyRepo;
    private final StatusRepo statusRepo;
    private final StatusItemRepo statusItemRepo;
    private final PersonRepo personRepo;
    private final SecurityGroupRepo securityGroupRepo;
    private final UserLoginRepo userLoginRepo;
    private final UserRestRepository userRestRepository;
    private final UserRegisterRepo userRegisterRepo;
    private final PartyService partyService;

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
        return userRestRepository.findByPartyTypeAndStatusAndFullNameLike(page,
                PartyType.PartyTypeEnum.PERSON.name(), Status.StatusEnum.PARTY_ENABLED.name(), sString);
    }

    @Override
    public Page<UserRestBriefProjection> findAll(Pageable page) {
        return userRestRepository.findAllDPerson(page);
    }

    @Override
    public List<UserLogin> getAllUserLogins() {
        return userLoginRepo.findAll();
    }

    @Override
    @Transactional
    public UserLogin createAndSaveUserLogin(String userName, String password) {     //test
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
    @Transactional
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

        UserLogin userLogin = new UserLogin(personModel.getUserName(), personModel.getEmail(),
                UserLogin.PASSWORD_ENCODER.encode(personModel.getPassword()), true, roles);
        userLogin.setParty(party);
        if (userLoginRepo.existsByUserLoginIdOrEmail(personModel.getUserName(), personModel.getEmail())) {
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

    @Override
    public UserRegister.OutputModel registerUser(UserRegister.InputModel inputModel) {
        String userLoginId = inputModel.getUserLoginId();
        String email = inputModel.getEmail();

        if (userRegisterRepo.existsByUserLoginIdOrEmail(userLoginId, email)
                || userLoginRepo.existsById(userLoginId)) {
            return new UserRegister.OutputModel();
        }

        StatusItem userRegistered = statusItemRepo.findById("USER_REGISTERED")
                .orElseThrow(NoSuchElementException::new);
        UserRegister userRegister = inputModel.createUserRegister(userRegistered);
        userRegister = userRegisterRepo.save(userRegister);

        return userRegister.toOutputModel();
    }

    @Override
    public boolean approveRegisterUser(String userLoginId) {
        UserRegister userRegister = userRegisterRepo.findById(userLoginId).orElse(null);
        if (userRegister == null)
            return false;

        try {
            createAndSaveUserLogin(new PersonModel(
                    userRegister.getUserLoginId(), userRegister.getPassword(),
                    userRegister.getEmail(),
                    new ArrayList<>(), userRegister.getUserLoginId(),
                    userRegister.getFirstName(), userRegister.getLastName(), userRegister.getMiddleName(),
                    null, null));
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        StatusItem userApproved =
                statusItemRepo.findById("USER_APPROVED").orElseThrow(NoSuchElementException::new);
        userRegister.setStatusItem(userApproved);
        userRegisterRepo.save(userRegister);
        return true;
    }

    @Override
    public List<UserRegister.OutputModel> findAllRegisterUser() {
        StatusItem userRegistered =
                statusItemRepo.findById("USER_REGISTERED").orElseThrow(NoSuchElementException::new);
        if (userRegistered != null) {
            List<UserRegister> userRegisters = userRegisterRepo.findAllByStatusItem(userRegistered);
            return userRegisters.stream().map(UserRegister::toOutputModel).collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

}
