package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.MessageMapper;

@Transactional
@Service
public class MessageServiceImpl implements MessageService {
  
  private final MessageMapper messageMapper;

  public MessageServiceImpl(MessageMapper messageMapper) {
    super();
    this.messageMapper = messageMapper;
  }
  
  @Override
  public List<EmployeeDto> getEmployeeList(Map<String, Object> param) {

    return messageMapper.getEmployeeList(param);
  }
  

//  public ResponseEntity<Map<String, Object>> getEmployeeList(Map<String, Object> param) {
//    Map<String, Object> map = new HashMap<>();
//    List<EmployeeDto> employeeList = messageMapper.getEmployeeList(param);
//    map.put("employeeList", employeeList);
//    
//    return new ResponseEntity<>(map, HttpStatus.OK);
//  }
}
