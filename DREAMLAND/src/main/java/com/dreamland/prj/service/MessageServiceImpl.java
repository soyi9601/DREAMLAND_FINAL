package com.dreamland.prj.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.MessageMapper;
import com.dreamland.prj.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Transactional
@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
  
  private final MessageMapper messageMapper;
  private final MyPageUtils myPageUtils;

  
  @Override
  public List<EmployeeDto> getEmployeeList(Map<String, Object> param) {

    return messageMapper.getEmployeeList(param);
  }
  
  @Override
  public int insertMessage(HttpServletRequest request) {
    int sender = Integer.parseInt(request.getParameter("sender"));
    String[] receiver = request.getParameterValues("receiver");
    String contents = request.getParameter("contents");
    
    Map<String, Object> param = new HashMap<>();
    int length = receiver.length;    
    int insertCount = 0;
    
    for(int i = 0 ; i < length ; i++) {
      param.put("sender", sender);
      param.put("receiver", Integer.parseInt(receiver[i]));
      param.put("contents", contents);
      insertCount += messageMapper.sendMessage(param);
    }

    System.out.println(insertCount);
    return insertCount;
  }
  
  @Override
  public int getReceiveCount(int empNo) {
    return messageMapper.getMessageCountByReceiver(empNo);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getReceiveMessage(HttpServletRequest request) {
    
    // 메시지 개수, 페이지번호, 한페이지당 보여지는 메시지 개수
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountByReceiver(empNo);
    
    int display = 5;
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    
    // 페이징처리
    myPageUtils.setPaging(total, display, page);
    
    String sort = "DESC";
    
    // 목록 가져올 때 전달 할 Map 생성
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);
    
    return new ResponseEntity<>(Map.of("messageList", messageMapper.getMessageByReceiver(empNo)
                                     , "totalPage", myPageUtils.getTotalPage()
                                     , "paging", myPageUtils.getPaging(request.getContextPath() + "/message/getReceiveMessage.do", sort, display))
                                , HttpStatus.OK);
  }
  
  @Override
  public int getSendCount(int empNo) {
    return messageMapper.getMessageCountBySender(empNo);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getSendMessage(HttpServletRequest request) {
    // 메시지 개수, 페이지번호, 한페이지당 보여지는 메시지 개수
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountBySender(empNo);
    
    int display = 5;
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    
    // 페이징처리
    myPageUtils.setPaging(total, display, page);
    
    String sort = "DESC";
    
    // 목록 가져올 때 전달 할 Map 생성
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);
    
    return new ResponseEntity<>(Map.of("messageList", messageMapper.getMessageBySender(empNo)
                                     , "totalPage", myPageUtils.getTotalPage()
                                     , "paging", myPageUtils.getPaging(request.getContextPath() + "/message/getSendMessage.do", sort, display))
                                , HttpStatus.OK);
  }
  

//  public ResponseEntity<Map<String, Object>> getEmployeeList(Map<String, Object> param) {
//    Map<String, Object> map = new HashMap<>();
//    List<EmployeeDto> employeeList = messageMapper.getEmployeeList(param);
//    map.put("employeeList", employeeList);
//    
//    return new ResponseEntity<>(map, HttpStatus.OK);
//  }
}
