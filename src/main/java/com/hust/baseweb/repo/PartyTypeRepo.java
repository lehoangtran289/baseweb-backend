package com.hust.baseweb.repo;

import com.hust.baseweb.entity.PartyType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface PartyTypeRepo extends JpaRepository<PartyType, String> {
    PartyType findByPartyTypeId(String id);
}
