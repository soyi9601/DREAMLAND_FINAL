package com.dreamland.prj.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface EmployeeMapper {
  int insertEmployee(EmployeeDto emp);
  EmployeeDto getEmployeeByMap(Map<String, Object> map);
//  int deleteUser(int userNo);
//  int insertAccessHistory(Map<String, Object> map);
//  int updateAccessHistory(String sessionId);
}
