package com.dreamland.prj.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class EmployeeDto implements UserDetails {
	
	private int empNo, dayOff, deptNo, posNo;
	private String empName, email, address, detailAddress, password, profilePath, signPath, mobile, role, postcode;
	private Date birth, enterDate, resignDate;
	
  private static final long serialVersionUID = 1L;
  
  
  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    Collection<GrantedAuthority> collect = new ArrayList<>();
    collect.add(new GrantedAuthority() {
      
      @Override
      public String getAuthority() {
        return role;
      }
    });

    return collect;
  }
  
  @Override
  public String getUsername() {

    return this.email;
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
    // TODO Auto-generated method stub
    return true;
  }
  
  @Override
  public String getPassword() {
    return this.password;
  }
	
	

}
