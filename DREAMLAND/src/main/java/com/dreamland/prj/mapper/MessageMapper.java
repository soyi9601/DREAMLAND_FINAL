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
  
  // 메시지 리스트 받아오기
  List<MessageDto> getMessageByReceiver(Map<String, Object> param);
  List<MessageDto> getMessageBySender(Map<String, Object> param);
  List<MessageDto> getMessageByStar(Map<String, Object> param);
  
  // 메시지 갯수
  int getMessageCountByReceiver(int empNo);
  int getMessageCountBySender(int empNo);
  int getMessageCountByStar(int empNo);
  int getMessageCountByRecStar(int empNo);
  
  // 메시지 디테일
  MessageDto getMessageDetail(int msgNo);
  
  // 읽음 여부 업데이트
  int updateMsgRead(int msgNo);
  
  // 저장 여부 업데이트
  int updateMsgStar(int msgNo);

}
