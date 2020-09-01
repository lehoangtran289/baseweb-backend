package com.hust.baseweb.service;

import com.hust.baseweb.entity.UserLogin;
import com.hust.baseweb.rest.user.DPerson;
import com.hust.baseweb.rest.user.UserRestBriefProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {
    UserLogin findById(String userLoginId);

    DPerson findByPartyId(String parytyId);

    Page<UserRestBriefProjection> findPersonByFullName(Pageable page, String sString);

}
