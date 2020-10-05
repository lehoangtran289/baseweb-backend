package com.hust.baseweb.rest.user;

import org.springframework.data.rest.core.config.Projection;

@Projection(name = "UserLoginProjection", types = {DPersonUserLogin.class})
public interface UserLoginProjection {
    String getUserLoginId();

    String getEmail();
}
