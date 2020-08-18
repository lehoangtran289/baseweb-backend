package com.hust.baseweb.repo;

import com.hust.baseweb.entity.Party;
import com.hust.baseweb.entity.UserLogin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserLoginRepo extends JpaRepository<UserLogin, String> {
    UserLogin findByUserLoginId(String userLoginId);

    UserLogin findByEmail(String email);

    UserLogin findByUserLoginIdOrEmail(String userLoginId, String email);

    Boolean existsByUserLoginIdOrEmail(String userLoginId, String email);

    Boolean existsByEmail(String email);

    List<UserLogin> findByParty(Party party);

}
