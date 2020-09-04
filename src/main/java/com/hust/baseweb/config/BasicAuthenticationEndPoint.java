package com.hust.baseweb.config;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.www.BasicAuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class BasicAuthenticationEndPoint extends BasicAuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
        response.sendError(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase());
    }

    @Override
    public void afterPropertiesSet() {
        setRealmName("Realm");
        super.afterPropertiesSet();
    }

    /**
     * For a web application, a realm is a complete database of users and groups
     * identified as valid users of a web application or a set of web applications
     * and controlled by the same authentication policy.
     */
}
