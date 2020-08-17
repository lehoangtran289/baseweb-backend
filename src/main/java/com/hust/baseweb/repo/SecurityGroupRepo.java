package com.hust.baseweb.repo;

import com.hust.baseweb.model.SecurityGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SecurityGroupRepo extends JpaRepository<SecurityGroup, String> {
    List<SecurityGroup> findAll();

    List<SecurityGroup> findAllByGroupIdIn(List<String> groupIds);
}
