package com.dreamland.prj.config.auth;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.dreamland.prj.dto.EmployeeDto;

// 시큐리티가 /login 주소 요청이 오면 낚아채서 로그인을 진행시킨다.
// 로그인 진행이 완료가 되면 시큐리티 session 을 만들어준다. (Security ContextHolder 에 세션 정보를 저장)
// 오브젝트 => Authentication 타입 객체
// Authentication 안에 User 정보가 있어야 됨.
// User 오브젝트의 타입 => UserDetails 타입 객체

// Security Session => Authentication => UserDetails (=PrincipalDetail)


public class PrincipalDetail implements UserDetails{

  /**
   * 
   */
  private static final long serialVersionUID = 1L;
  private EmployeeDto emp; // 콤포지션
  private PrincipalDetailsService principalDetailsService;
  
  public PrincipalDetail(EmployeeDto emp) {
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

  @Override
  public String getPassword() {
    // TODO Auto-generated method stub
    return emp.getPassword();
  }

  @Override
  public String getUsername() {
    // TODO Auto-generated method stub
    return emp.getId()+"";
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
  
  // 회원정보 가져오기
  
  // 프로필경로
  public String getProfilePath() {
    return emp.getProfilePath();
  }
  
  // 이름
  public String getEmpName() {
    return emp.getEmpName();
  }
   
  // 생년월일
  public Date getBirth() {
    return emp.getBirth();
  }
  
  // 휴대전화
  public String getMobile() {
    return emp.getMobile();
  }
  
  // 이메일
  public String getEmail() {
    return emp.getEmail();
  }
  
  // 부서
  public int getDeptNo() {
    return emp.getDeptNo();
  }
  
  // 직급
  public int getPosNo() {
    return emp.getPosNo();
  }
  
  // 입사일
  public Date getEnterDate() {
    return emp.getEnterDate();
  }
  
  // 권한
  public String getRole() {
    return emp.getRole();
  }

}
