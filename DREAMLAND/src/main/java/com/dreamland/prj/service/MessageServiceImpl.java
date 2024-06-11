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

    return insertCount;
  }
  
  @Override
  public Map<String, Object> getReceiveCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByRecRead(empNo));
    total.put("total", messageMapper.getMessageCountByReceiver(empNo));
    return total;
  }
  
  @Override
  public void getReceiveMessage(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int total = messageMapper.getMessageCountByReceiver(empNo);
    int nonStar = messageMapper.getMessageCountByRecStar(empNo);
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("5"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(nonStar, display, page);
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Map<String, Object> map = Map.of("empNo", empNo, "begin", myPageUtils.getBegin(), "end", myPageUtils.getEnd(), "total", nonStar);

    List<MessageDto> msgs = messageMapper.getMessageByReceiver(map);
    
    for(MessageDto msg : msgs) {
      String originContents = msg.getMsgContents();
      if(originContents.length() > 50) {
        String truncatedContents = originContents.substring(0, 50) + "...";
        msg.setMsgContents(truncatedContents);
      }
    }
    model.addAttribute("beginNo", nonStar - (page - 1) * display);
    model.addAttribute("receiveList", msgs);
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/user/receiveBox?empNo=" + empNo, sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
    
  }
  
  @Override
  public int getSendCount(int empNo) {
    return messageMapper.getMessageCountBySender(empNo);
  }
  
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
      if(originContents.length() > 50) {
        String truncatedContents = originContents.substring(0, 50) + "...";
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

  @Override
  public void getMessageDetailByReceive(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int msgNo = Integer.parseInt(request.getParameter("msgNo"));
    int updateReadYN = messageMapper.updateMsgRead(msgNo);
    
    model.addAttribute("msgDetail", messageMapper.getMessageDetail(msgNo));
    
  }
  
  @Override
  public void getMessageDetailBySend(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int msgNo = Integer.parseInt(request.getParameter("msgNo"));
    
    model.addAttribute("msgDetail", messageMapper.getMessageDetail(msgNo));
    
  }
  
  @Override
  public int saveMessage(HttpServletRequest request) {
    
    String[] saveList = request.getParameterValues("checkYn");
    
    int count = 0;
    // 문자열 배열을 int 배열로 변환
    int[] msgNoList = new int[saveList.length];
    for (int i = 0; i < saveList.length; i++) {
      msgNoList[i] = Integer.parseInt(saveList[i]);
      messageMapper.updateMsgStar(msgNoList[i]);
      count++;
    }
    
    return count;
  }
  
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
  
  @Override
  public Map<String, Object> getStarCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByStarRead(empNo));
    total.put("total", messageMapper.getMessageCountByStar(empNo));
    return total;
  }
  
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
  
  @Override
  public Map<String, Object> getDeleteCount(int empNo) {
    Map<String, Object> total = new HashMap<>();
    total.put("notReadCount", messageMapper.getMessageCountByDeleteRead(empNo));
    total.put("total", messageMapper.getMessageCountByDelete(empNo));
    return total;
  }
  
  @Override
  public void setReply(Model model) {
    
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    int senderNo = Integer.parseInt(request.getParameter("senderNo"));
    
    EmployeeDto emp = messageMapper.getEmployeeBySender(senderNo);
    model.addAttribute("sender", emp);

  }
  
}
