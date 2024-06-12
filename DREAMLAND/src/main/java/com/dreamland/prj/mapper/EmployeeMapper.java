package com.dreamland.prj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PositionDto;

@Mapper
public interface EmployeeMapper {
  int insertEmployee(EmployeeDto emp);
  EmployeeDto getEmployeeByEmail(String email);
  EmployeeDto getEmployeeByEmpNo(int empNo);
  
  List<DepartmentDto> getDeptList();
  List<PositionDto> getPosList();
  int updateUserInfo(EmployeeDto emp);
  int updatePassword(String email, String changePw);
  

}
