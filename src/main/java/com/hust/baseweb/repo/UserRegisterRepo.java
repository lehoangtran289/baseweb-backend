package com.hust.baseweb.repo;

import com.hust.baseweb.entity.StatusItem;
import com.hust.baseweb.entity.UserRegister;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRegisterRepo extends JpaRepository<UserRegister, String> {
    List<UserRegister> findAllByStatusItem(StatusItem statusItem);

    boolean existsByUserLoginIdOrEmail(String userLoginId, String email);
}
