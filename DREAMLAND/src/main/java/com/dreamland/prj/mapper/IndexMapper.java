package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.WorkDto;

@Mapper
public interface IndexMapper {

  EmployeeDto getUser(String email);    // 직원조회
  
  void insertWork(WorkDto work);        // 출근
  void updateWorkOut(WorkDto work);     // 퇴근
}
