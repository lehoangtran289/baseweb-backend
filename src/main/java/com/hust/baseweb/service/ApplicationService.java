package com.hust.baseweb.service;

import com.hust.baseweb.entity.Application;
import com.hust.baseweb.entity.SecurityPermission;

import java.util.List;

public interface ApplicationService {

    List<Application> getListByTypeAndPermission(String applicationType, List<SecurityPermission> permissions);

}