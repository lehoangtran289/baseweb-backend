package com.hust.baseweb.service;

import com.hust.baseweb.entity.Application;
import com.hust.baseweb.entity.SecurityPermission;
import com.hust.baseweb.repo.ApplicationRepo;
import com.hust.baseweb.repo.ApplicationTypeRepo;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
@Log4j2
public class ApplicationServiceImpl implements ApplicationService {

    private ApplicationRepo applicationRepo;
    private ApplicationTypeRepo applicationTypeRepo;

    @Override
    public Set<Application> getListByTypeAndPermission(String applicationType,
                                                       List<SecurityPermission> permissions) {

        String permissionStr = permissions.stream().map(SecurityPermission::getPermissionId)
                .collect(Collectors.joining(", "));
        log.info("getListByPermissionAndType, permissionList = " + permissionStr + ", type = " + applicationType);

        List<Application> applicationList = applicationRepo.findByApplicationTypeAndSecurityPermissionIn(
                applicationTypeRepo.getOne(applicationType), permissions);

        List<Application> applicationList1 =
                applicationList.stream().filter(application -> application != null && application.getModule() != null)
                        .map(Application::getModule)
                        .collect(Collectors.toList());
        log.info("ApplicationList.sz = " + applicationList.size() + ", ApplicationList1.sz = " + applicationList1.size());

        applicationList.addAll(applicationList1);
        System.out.println(applicationList.stream().map(Application::getApplicationId).collect(Collectors.joining(", ")));

        return new HashSet<>(applicationList);
    }

}
