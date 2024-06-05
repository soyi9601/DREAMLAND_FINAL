package com.dreamland.prj.config;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.service.LoginService;

import lombok.RequiredArgsConstructor;

// 시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC 되어 있는 loadUserByUsername 함수가 실행
@Component
@RequiredArgsConstructor
public class DBConnectionProvider implements UserDetailsService, AuthenticationProvider{

  private final LoginService loginService;

  // 비밀번호 암호화 처리
  private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

  @Override
  public Authentication authenticate(Authentication authentication) throws AuthenticationException {

    String email = authentication.getName();
    String pw = (String)authentication.getCredentials();
    
    EmployeeDto loginEmployee = loginService.getEmployeeByEmail(email);
    PrincipalUser user = new PrincipalUser(loginEmployee);
    
    if (loginEmployee == null || 
        (!encoder.matches(pw, loginEmployee.getPassword())&&!pw.equals("updateData"))) {
      throw new BadCredentialsException("인증에 실패하셨습니다!");

    }
    
    //return new UsernamePasswordAuthenticationToken(loginEmployee, loginEmployee.getPassword(), loginEmployee.getAuthorities());
    return new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
  }

  @Override
  public boolean supports(Class<?> authentication) {
    // TODO Auto-generated method stub
    return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
  }

  
  // 시큐리티 session( Authentication(내부 UserDetails))
  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    EmployeeDto emp = loginService.getEmployeeByEmail(username);
    if(emp == null) {
      throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
    } else {
      return new PrincipalUser(emp);
    }
  }

}
