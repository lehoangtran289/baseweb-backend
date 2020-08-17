package com.hust.baseweb.config;

import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

import java.util.Optional;

public class SpringSecurityAuditorAware implements AuditorAware<String> {

    @Override
    public Optional<String> getCurrentAuditor() {
        return Optional.ofNullable(SecurityContextHolder.getContext())
                .map(SecurityContext::getAuthentication)    // obtain currently authenticated principal
                .filter(Authentication::isAuthenticated)    // if authenticated = true
                    .map(Authentication::getPrincipal)      // the principal being authenticated
                    .map(User.class::cast)                  // cast to User
                    .map(user -> user.getUsername());       // return username
    }
}
