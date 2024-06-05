package com.dreamland.prj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.MessageServiceImpl;

@Controller
public class MessageController {
  
  @Autowired
  private MessageServiceImpl messageServiceImpl;
  
  @GetMapping("/user/employeeList")
  public @ResponseBody Map<String, Object> getEmployeeList(@RequestParam Map<String, Object> param) {
    List<EmployeeDto> resultList = messageServiceImpl.getEmployeeList(param);
    param.put("resultList", resultList);
    return param;
  }
  

}
