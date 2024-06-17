package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.MessageDto;

/******************************************
 * 
 * - 쪽지 mapper
 * 작성자 : 고은정
 * 
 * ****************************************/

@Mapper
public interface MessageMapper {
  
  // 받는사람 리스트 가져오기
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);
  
  // 쪽지보내기
  int sendMessage(Map<String, Object> param);
  
  // 메시지 리스트 받아오기
  List<MessageDto> getMessageByReceiver(Map<String, Object> param);
  List<MessageDto> getMessageBySender(Map<String, Object> param);
  List<MessageDto> getMessageByStar(Map<String, Object> param);
  List<MessageDto> getMessageByDelete(Map<String, Object> param);
  
  // 메시지 갯수
  int getMessageCountByReceiver(int empNo);
  int getMessageCountByRecRead(int empNo);
  int getMessageCountByRecStar(int empNo);
  int getMessageCountBySender(int empNo);
  int getMessageCountByStar(int empNo);
  int getMessageCountByStarRead(int empNo);
  int getMessageCountByDelete(int empNo);
  int getMessageCountByDeleteRead(int empNo);
  
  // 메시지 디테일
  MessageDto getMessageDetail(int msgNo);
  
  // 읽음 여부 업데이트
  int updateMsgRead(int msgNo);
  
  // 저장 여부 업데이트
  int updateRecMsgStar(int msgNo);
  int updateSendMsgStar(int msgNo);
  
  // 삭제 여부 업데이트
  int updateRecMsgDelete(int msgNo);
  int updateSendMsgDelete(int msgNo);
  
  // 스케줄러용 논리삭제
  void deleteOldMessages();
  
  // 답장할 직원 정보
  EmployeeDto getEmployeeBySender(int senderNo);

}
