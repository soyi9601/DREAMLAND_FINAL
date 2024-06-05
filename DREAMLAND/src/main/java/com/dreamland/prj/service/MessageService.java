package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;

public interface MessageService {
  
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);
  int insertMessage(HttpServletRequest request);
  
  int getReceiveCount(int empNo);
  ResponseEntity<Map<String, Object>> getReceiveMessage(HttpServletRequest request);
  
  int getSendCount(int empNo);
  ResponseEntity<Map<String, Object>> getSendMessage(HttpServletRequest request);

}
