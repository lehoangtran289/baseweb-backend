package com.hust.baseweb.service;

import com.hust.baseweb.entity.SecurityGroup;
import com.hust.baseweb.entity.UserLogin;
import com.hust.baseweb.repo.UserLoginRepo;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class BaseWebUserDetailService implements UserDetailsService {
    private UserLoginRepo userLoginRepo;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        UserLogin user = userLoginRepo.findByUserLoginIdOrEmail(s, s);
        List<GrantedAuthority> authorities =
                AuthorityUtils.createAuthorityList(
                        user.getRoles().stream().map(SecurityGroup::getGroupId).toArray(String[]::new));

        return new User(user.getUserLoginId(), user.getPassword(), authorities);

    }

}
