package com.macro.mall.api.bo;

import com.macro.mall.model.FacStudent;
import com.macro.mall.model.UmsAdmin;
import com.macro.mall.model.UmsPermission;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * SpringSecurity需要的用户详情
 * Created by macro on 2018/4/26.
 */
public class AdminUserDetails implements UserDetails {
    private UmsAdmin umsAdmin;
    private List<UmsPermission> permissionList;

    private FacStudent facStudent;

    public AdminUserDetails(UmsAdmin umsAdmin, List<UmsPermission> permissionList) {
        this.umsAdmin = umsAdmin;
        this.permissionList = permissionList;

    }

    public AdminUserDetails(FacStudent facStudent) {
        this.facStudent = facStudent;

    }



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

            List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
            GrantedAuthority au = new SimpleGrantedAuthority("ROLE_USER");
            list.add(au);
            return list;

    }

    @Override
    public String getPassword() {
        return facStudent.getPassword();
    }

    @Override
    public String getUsername() {
        return facStudent.getIphone();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
