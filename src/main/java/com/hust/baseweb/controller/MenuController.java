package com.hust.baseweb.controller;

import com.hust.baseweb.constant.ApplicationTypeConstant;
import com.hust.baseweb.entity.Application;
import com.hust.baseweb.entity.SecurityPermission;
import com.hust.baseweb.entity.UserLogin;
import com.hust.baseweb.service.ApplicationService;
import com.hust.baseweb.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@AllArgsConstructor(onConstructor = @__(@Autowired))
@CrossOrigin
@Log4j2
public class MenuController {
    public static final String module = MenuController.class.getName();
    private ApplicationService applicationService;
    private UserService userService;

    @GetMapping("/menu")
    public ResponseEntity<?> getMenu(Principal principal) {
        UserLogin userLogin = userService.findById(principal.getName());

        List<SecurityPermission> permissionList = new ArrayList<>();
        userLogin.getRoles().forEach(sp -> permissionList.addAll(sp.getPermissions()));

        return ResponseEntity.ok().body(
                applicationService.getListByTypeAndPermission(ApplicationTypeConstant.MENU, permissionList)
                        .stream().map(Application::getApplicationId)
                        .collect(Collectors.toSet()));
    }
}
