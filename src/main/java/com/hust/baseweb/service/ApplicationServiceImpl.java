package com.hust.baseweb.service;

import com.hust.baseweb.entity.Application;
import com.hust.baseweb.entity.SecurityPermission;
import com.hust.baseweb.repo.ApplicationRepo;
import com.hust.baseweb.repo.ApplicationTypeRepo;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
@Log4j2
public class ApplicationServiceImpl implements ApplicationService {

    private ApplicationRepo applicationRepo;
    private ApplicationTypeRepo applicationTypeRepo;

    @Override
    public List<Application> getListByTypeAndPermission(String applicationType,
                                                        List<SecurityPermission> permissions) {

        String permissionStr = permissions.stream().map(p -> p.getPermissionId())
                .collect(Collectors.joining(", "));

        List<Application> applicationList = applicationRepo
                .findByApplicationTypeAndSecurityPermissionIn(applicationRepo.getOne(applicationType),
                        permissions);

        List<Application> applicationList1 = applicationList.stream().map(Application::getModule)
                .collect(Collectors.toList());

        List<Application> applicationList2 = applicationList1.stream().filter(app -> app.getModule() != null)
                .map(app -> app.getModule()).collect(Collectors.toList());

        log.info("getListByTypeAndPermission, permissionList = " + permissionStr + ", type = " + applicationType +
                ", applicationList.sz = " + applicationList.size() + ", applicationModuleList1.sz = "
                + applicationList1.size() + ", applicationModuleList2.sz = "
                + applicationList2.size());

        applicationList.addAll(applicationList1);
        applicationList.addAll(applicationList2);
        applicationList.removeIf(Objects::isNull);
        return applicationList;
    }

}
