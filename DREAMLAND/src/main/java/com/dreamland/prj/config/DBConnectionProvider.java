package com.dreamland.prj.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.EmployeeMapper;
import com.dreamland.prj.service.EmployeeServiceImpl;
import com.dreamland.prj.service.LoginService;

import lombok.RequiredArgsConstructor;

// 시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC 되어 있는 loadUserByUsername 함수가 실행
@Component
@RequiredArgsConstructor
public class DBConnectionProvider implements UserDetailsService, AuthenticationProvider{

  private final LoginService loginService;
  
  // 시큐리티 session( Authentication(내부 UserDetails))
  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    EmployeeDto emp = loginService.getEmployeeByEmail(username);
    
    if(emp == null) {
      throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
    } else {
      return emp;
    }
  }

  @Override
  public Authentication authenticate(Authentication authentication) throws AuthenticationException {
    String email = authentication.getName();
    String pw = (String)authentication.getCredentials();
    
    EmployeeDto loginEmployee = loginService.getEmployeeByEmail(email);
    
    return new UsernamePasswordAuthenticationToken(loginEmployee, loginEmployee.getPassword(), loginEmployee.getAuthorities());
  }

  @Override
  public boolean supports(Class<?> authentication) {
    // TODO Auto-generated method stub
    return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
  }
}
