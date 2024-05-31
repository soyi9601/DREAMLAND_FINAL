package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface IndexMapper {

  EmployeeDto getUser(String email);
  
}
