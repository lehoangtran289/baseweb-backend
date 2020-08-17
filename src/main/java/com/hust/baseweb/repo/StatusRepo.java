package com.hust.baseweb.repo;

import com.hust.baseweb.model.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatusRepo extends JpaRepository<Status, String> {
    Status findByStatusId(String statusId);
}
