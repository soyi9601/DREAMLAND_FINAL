package com.dreamland.prj.config.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.EmployeeServiceImpl;

// 시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC 되어 있는 loadUserByUsername 함수가 실행
@Service
public class PrincipalDetailsService implements UserDetailsService{

  @Autowired
  private EmployeeServiceImpl employeeService;
  
  // 시큐리티 session( Authentication(내부 UserDetails))
  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    EmployeeDto emp = employeeService.signin(username);
    
    if(emp != null) {
      return new PrincipalDetail(emp);
    } else {
      throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
    }
  }
  
  public String getDeptName(int deptNo) {
    String deptName = employeeService.getDeptNameByDeptNo(deptNo);
    return deptName;
  }
  
  public String getPosName(int posNo) {
    String posName = employeeService.getPosNameByPosNo(posNo);
    return posName;
  }

}
