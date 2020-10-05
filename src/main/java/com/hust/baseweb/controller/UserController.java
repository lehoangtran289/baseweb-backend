package com.hust.baseweb.controller;

import com.hust.baseweb.entity.Party;
import com.hust.baseweb.entity.SecurityGroup;
import com.hust.baseweb.entity.SecurityPermission;
import com.hust.baseweb.entity.UserLogin;
import com.hust.baseweb.model.DPersonDetailModel;
import com.hust.baseweb.model.PersonModel;
import com.hust.baseweb.model.PersonUpdateModel;
import com.hust.baseweb.rest.user.DPerson;
import com.hust.baseweb.service.PartyService;
import com.hust.baseweb.service.SecurityGroupService;
import com.hust.baseweb.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.hateoas.Link;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@Log4j2
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class UserController {

    public static final String EDIT_REL = "edit";
    public static final String DELETE_REL = "delete";
    private UserService userService;
    private PartyService partyService;
    private SecurityGroupService securityGroupService;

    @GetMapping(path = "/users")
    public ResponseEntity<?> getUsers(Principal principal, Pageable page,
                                      @RequestParam(required = false) String search,
                                      @RequestParam(required = false) String filter) {
        if (search != null) {
            log.info("::getUsers, searchString = " + search);
            return ResponseEntity.ok().body(userService.findPersonByFullName(page, search));
        }
        return ResponseEntity.ok().body(userService.findPersonByFullName(page, ""));
    }

    @GetMapping(path = "/users/{partyId}")
    public ResponseEntity<?> getUserDetail(Principal principal, @PathVariable String partyId) {
        DPerson person = userService.findByPartyId(partyId);
        DPersonDetailModel detailModel = new DPersonDetailModel(person);
        UserLogin userLogin = userService.findById(principal.getName());

        List<SecurityPermission> permissionList = new ArrayList<>();
        userLogin.getRoles().forEach(sg -> permissionList.addAll(sg.getPermissions()));

        List<SecurityPermission> lf = permissionList.stream()
                .filter(permission -> permission.getPermissionId().equals("USER_CREATE"))
                .collect(Collectors.toList());

        if (lf.size() > 0) {
            detailModel.add(new Link("/user", EDIT_REL));
            detailModel.add(new Link("/user", DELETE_REL));
        }
        return ResponseEntity.ok().body(detailModel);

    }

    @PostMapping(path = "/users")
    public ResponseEntity<?> save(Principal principal, @RequestBody PersonModel personModel) {
        Party party;
        try {
            party = userService.createAndSaveUserLogin(personModel);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(party.getPartyId());
    }

    @PutMapping(path = "/user/{partyId}")
    public ResponseEntity<?> update(Principal principal, @RequestBody PersonUpdateModel personUpdateModel,
                                    @PathVariable String partyId) {

        Party party = userService.update(personUpdateModel, UUID.fromString(partyId));
        return ResponseEntity.ok().body(party.getPartyId());
    }

    @DeleteMapping(path = "/users/{partyId}")
    public ResponseEntity<?> delete(Principal principal, @PathVariable String partyId) {
        partyService.disableParty(partyId);
        return ResponseEntity.ok("");
    }

    // ------------------------------------------

    @GetMapping("/get-all-user-login-ids")
    public ResponseEntity<List<String>> getAllUserLoginIds() {
        return ResponseEntity.ok(userService.getAllUserLogins().stream()
                .map(UserLogin::getUserLoginId).collect(Collectors.toList()));
    }

    @GetMapping(path = "/get-security-groups")
    public ResponseEntity<?> getSecurityGroups(Principal principal) {
        List<SecurityGroup> securityGroups = securityGroupService.findAll();
        return ResponseEntity.ok().body(securityGroups);
    }

}
