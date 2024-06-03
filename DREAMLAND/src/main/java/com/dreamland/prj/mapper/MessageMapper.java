package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface MessageMapper {
  
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);

}
