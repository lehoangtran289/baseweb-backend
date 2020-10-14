package com.hust.baseweb.service;

import com.hust.baseweb.entity.Application;
import com.hust.baseweb.entity.SecurityPermission;

import java.util.List;
import java.util.Set;

public interface ApplicationService {

    Set<Application> getListByTypeAndPermission(String applicationType, List<SecurityPermission> permissions);

}
