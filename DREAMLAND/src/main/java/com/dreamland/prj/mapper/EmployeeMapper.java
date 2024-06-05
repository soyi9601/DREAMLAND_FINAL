package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface EmployeeMapper {
  int insertEmployee(EmployeeDto emp);
  EmployeeDto getEmployeeByEmail(String email);
  String getDeptNameByDeptNo(int deptNo);
  String getPosNameByPosNo(int posNo);
  int updateUserInfo(EmployeeDto emp);
  int updatePassword(String email, String changePw);
//  int deleteUser(int userNo);
//  int insertAccessHistory(Map<String, Object> map);
//  int updateAccessHistory(String sessionId);
}
