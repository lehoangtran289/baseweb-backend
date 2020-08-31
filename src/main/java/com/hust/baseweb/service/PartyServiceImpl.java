package com.hust.baseweb.service;

import com.hust.baseweb.entity.Party;
import com.hust.baseweb.entity.PartyType;
import com.hust.baseweb.entity.Status;
import com.hust.baseweb.repo.PartyRepo;
import com.hust.baseweb.repo.PartyTypeRepo;
import com.hust.baseweb.repo.StatusRepo;
import com.hust.baseweb.entity.Status.StatusEnum;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class PartyServiceImpl implements PartyService{
    private PartyRepo partyRepo;
    private PartyTypeRepo partyTypeRepo;
    private StatusRepo statusRepo;

    @Override
    public Party save(String partyTypeId) {
        PartyType partyType = partyTypeRepo.getOne(partyTypeId);
        Party party = new Party();
        party.setType(partyType);
        return partyRepo.save(party);
    }

    @Override
    public Party disableParty(String partyId) {
        Party party = partyRepo.findById(UUID.fromString(partyId)).get();
        party.setPartyStatus(statusRepo.getOne(StatusEnum.PARTY_DISABLED.name()));
        return partyRepo.save(party);
    }

    @Override
    public Party findByPartyId(UUID partyId) {
        return partyRepo.findByPartyId(partyId);
    }
}
