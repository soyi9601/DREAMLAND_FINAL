package com.dreamland.prj.dto;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Builder;
import lombok.Data;

@Data
public class PrincipalUser implements UserDetails{
  private static final long serialVersionUID = 1L;
  private EmployeeDto emp; // 콤포지션
  
  public PrincipalUser(EmployeeDto emp) {
    super();
    this.emp = emp;
  }
  
  // 해당 Emp 의 권한을 리턴하는 곳
  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    Collection<GrantedAuthority> collect = new ArrayList<>();
    collect.add(new GrantedAuthority() {
      
      @Override
      public String getAuthority() {
        return emp.getRole();
      }
    });

    return collect;
  }
  
  public EmployeeDto getEmployeeDto() {
    return this.emp;
  }

  @Override
  public String getPassword() {
    // TODO Auto-generated method stub
    return emp.getPassword();
  }

  @Override
  public String getUsername() {
    // TODO Auto-generated method stub
    return emp.getEmail();
  }

  @Override
  public boolean isAccountNonExpired() {
    // TODO Auto-generated method stub
    return true;
  }

  @Override
  public boolean isAccountNonLocked() {
    // TODO Auto-generated method stub
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    // TODO Auto-generated method stub
    return true;
  }

  @Override
  public boolean isEnabled() {
    // 현재 사이트에서 1년동안 회원이 로그인을 안하면 휴면 계정을 하기로 함
    return true;
  }



}
