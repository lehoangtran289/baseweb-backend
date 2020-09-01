package com.hust.baseweb.rest.user;

import com.hust.baseweb.entity.PartyType;
import org.springframework.data.rest.core.config.Projection;

@Projection(name = "PartyTypeProjection", types = {PartyType.class})
public interface PartyTypeProjection {

    String getPartyTypeId();
}
