package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.MessageDto;

@Mapper
public interface MessageMapper {
  
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);
  int sendMessage(Map<String, Object> param);
  List<MessageDto> getMessageByReceiver(int empNo);
  List<MessageDto> getMessageBySender(int empNo);
  
  int getMessageCountByReceiver(int empNo);
  int getMessageCountBySender(int empNo);

}
