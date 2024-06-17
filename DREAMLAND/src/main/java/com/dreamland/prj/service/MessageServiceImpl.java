package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.MessageDto;
import com.dreamland.prj.mapper.MessageMapper;
import com.dreamland.prj.utils.MyMessagePageUtils;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Transactional
@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
  
  private final MessageMapper messageMapper;
  private final MyMessagePageUtils myPageUtils;

  //받는사람 리스트 가져오기 
  @Override
  public List<EmployeeDto> getEmployeeList(Map<String, Object> param) {

    return messageMapper.getEmployeeList(param);
  }
  
  //쪽지 보내기
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

    return insertCount;
  }
  
  // 받은쪽지 개수
  @Override
  public Map<String, Object> getReceiveCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByRecRead(empNo));
    total.put("total", messageMapper.getMessageCountByReceiver(empNo));
    return total;
  }
  
  // 받은 쪽지 리스트 페이징 처리
  @Override
  public void getReceiveMessage(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountByReceiver(empNo);
    int nonRead = messageMapper.getMessageCountByRecRead(empNo);
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("5"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(total, display, page);
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);

    List<MessageDto> msgs = messageMapper.getMessageByReceiver(map);
    
    for(MessageDto msg : msgs) {
      String originContents = msg.getMsgContents();
      if(originContents.length() > 50) {
        String truncatedContents = originContents.substring(0, 50) + "...";
        msg.setMsgContents(truncatedContents);
      } 
    }
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("receiveList", msgs);
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/user/receiveBox?empNo=" + empNo, sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
    
  }
  
  // 보낸 쪽지 개수
  @Override
  public int getSendCount(int empNo) {
    return messageMapper.getMessageCountBySender(empNo);
  }
  
  //보낸 쪽지 리스트 페이징 처리
  @Override
  public void getSendMessage(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountBySender(empNo);
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("5"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(total, display, page);
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);
    
    List<MessageDto> msgs = messageMapper.getMessageBySender(map);
    
    for(MessageDto msg : msgs) {
      String originContents = msg.getMsgContents();
      if(originContents.length() > 40) {
        String truncatedContents = originContents.substring(0, 40) + "...";
        msg.setMsgContents(truncatedContents);
      }
    }

    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("sendList", msgs);
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/user/sendBox?empNo=" + empNo, sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);

  }

  // 받은쪽지함에서 쪽지 상세보기
  @Override
  public void getMessageDetailByReceive(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int msgNo = Integer.parseInt(request.getParameter("msgNo"));
    messageMapper.updateMsgRead(msgNo);
    
    model.addAttribute("msgDetail", messageMapper.getMessageDetail(msgNo));
    
  }

  // 보낸쪽지함에서 쪽지 상세보기
  @Override
  public void getMessageDetailBySend(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int msgNo = Integer.parseInt(request.getParameter("msgNo"));
    
    model.addAttribute("msgDetail", messageMapper.getMessageDetail(msgNo));
    
  }
  
  // 받은쪽지함에서 보관
  @Override
  public int saveRecMessage(HttpServletRequest request) {
    
    String[] saveList = request.getParameterValues("checkYn");
    
    int count = 0;
    // 문자열 배열을 int 배열로 변환
    int[] msgNoList = new int[saveList.length];
    for (int i = 0; i < saveList.length; i++) {
      msgNoList[i] = Integer.parseInt(saveList[i]);
      messageMapper.updateRecMsgStar(msgNoList[i]);
      count++;
    }
    
    return count;
  }
  
  // 보낸쪽지함에서 보관
  @Override
  public int saveSendMessage(HttpServletRequest request) {
    String[] saveList = request.getParameterValues("checkYn");
    
    int count = 0;
    // 문자열 배열을 int 배열로 변환
    int[] msgNoList = new int[saveList.length];
    for (int i = 0; i < saveList.length; i++) {
      msgNoList[i] = Integer.parseInt(saveList[i]);
      messageMapper.updateSendMsgStar(msgNoList[i]);
      count++;
    }
    
    return count;
  }
  
  // 보관 쪽지 리스트 페이징 처리
  @Override
  public void getStarMessage(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountByStar(empNo);
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("5"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(total, display, page);
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);
    
    List<MessageDto> msgs = messageMapper.getMessageByStar(map);
    
    for(MessageDto msg : msgs) {
      String originContents = msg.getMsgContents();
      if(originContents.length() > 50) {
        String truncatedContents = originContents.substring(0, 50) + "...";
        msg.setMsgContents(truncatedContents);
      }
    }

    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("saveList", msgs);
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/user/saveBox?empNo=" + empNo, sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
    
  }
  
  // 보관된 쪽지 개수
  @Override
  public Map<String, Object> getStarCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByStarRead(empNo));
    total.put("total", messageMapper.getMessageCountByStar(empNo));
    return total;
  }
  
  // 받은쪽지함에서 삭제
  @Override
  public int deleteRecMessage(HttpServletRequest request) {
    
    String[] saveList = request.getParameterValues("checkYn");
    
    int count = 0;
    // 문자열 배열을 int 배열로 변환
    int[] msgNoList = new int[saveList.length];
    for (int i = 0; i < saveList.length; i++) {
      msgNoList[i] = Integer.parseInt(saveList[i]);
      messageMapper.updateRecMsgDelete(msgNoList[i]);
      count++;
    }
    
    return count;
  }
  
  // 보낸쪽지함에서 삭제
  @Override
  public int deleteSendMessage(HttpServletRequest request) {
    String[] saveList = request.getParameterValues("checkYn");

    int count = 0;
    // 문자열 배열을 int 배열로 변환
    int[] msgNoList = new int[saveList.length];
    for (int i = 0; i < saveList.length; i++) {
      msgNoList[i] = Integer.parseInt(saveList[i]);
      messageMapper.updateSendMsgDelete(msgNoList[i]);
      count++;
    }
    
    return count;
  }
  
  // 휴지통 리스트 페이징 처리
  @Override
  public void getDeleteMessage(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountByDelete(empNo);
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("5"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(total, display, page);
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", total);
    
    List<MessageDto> msgs = messageMapper.getMessageByDelete(map);
    
    for(MessageDto msg : msgs) {
      String originContents = msg.getMsgContents();
      if(originContents.length() > 50) {
        String truncatedContents = originContents.substring(0, 50) + "...";
        msg.setMsgContents(truncatedContents);
      }
    }
    
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("deleteList", msgs);
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/user/removeBox?empNo=" + empNo, sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
    
  }
  
  // 삭제된 쪽지 개수
  @Override
  public Map<String, Object> getDeleteCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByDeleteRead(empNo));
    total.put("total", messageMapper.getMessageCountByDelete(empNo));
    return total;
  }
  
  // 논리적 완전삭제(스케줄러용)
  @Override
  public void realDeleteMessage() {
    // TODO Auto-generated method stub
    messageMapper.deleteOldMessages();
    
  }
  
  // 답장하기
  @Override
  public void setReply(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int senderNo = Integer.parseInt(request.getParameter("senderNo"));
    
    EmployeeDto emp = messageMapper.getEmployeeBySender(senderNo);
    model.addAttribute("sender", emp);

  }
  
}
