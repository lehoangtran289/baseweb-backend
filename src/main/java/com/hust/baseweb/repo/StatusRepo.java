package com.hust.baseweb.repo;

import com.hust.baseweb.entity.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StatusRepo extends JpaRepository<Status, String> {
    Optional<Status> findById(String id);
}
