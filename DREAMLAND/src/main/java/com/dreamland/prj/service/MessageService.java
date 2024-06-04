package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import com.dreamland.prj.dto.EmployeeDto;

public interface MessageService {
  
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);

}
