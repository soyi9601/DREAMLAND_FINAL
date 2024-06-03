package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.WorkDto;

@Mapper
public interface IndexMapper {

  EmployeeDto getUser(String email);
  
  void insertWork(WorkDto work);
  void updateWorkOut(WorkDto work);
}
