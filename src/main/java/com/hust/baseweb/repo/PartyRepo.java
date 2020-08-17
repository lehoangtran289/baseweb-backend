package com.hust.baseweb.repo;

import com.hust.baseweb.model.Party;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PartyRepo extends JpaRepository<Party, UUID> {
    Party findByPartyId(UUID partyId);
}
