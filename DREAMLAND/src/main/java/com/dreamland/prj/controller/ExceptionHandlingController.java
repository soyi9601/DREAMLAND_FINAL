package com.dreamland.prj.controller;


import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ExceptionHandlingController implements ErrorController{
  private final Logger logger = LoggerFactory.getLogger(this.getClass());
  
  // 에러 페이지 정의
  private final String ERROR_404_PAGE_PATH = "error/404";
  private final String ERROR_500_PAGE_PATH = "error/500";
  private final String ERROR_ETC_PAGE_PATH = "error/error";
  
  @GetMapping(value ="/error")
  public String handleError(HttpServletRequest request, Model model) {
    
    // 에러코드 획득
    Object status=request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
    
    // 에러코드 상태 정보
    HttpStatus httpStatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));
    
    if(status != null) {
      int statusCode = Integer.valueOf(status.toString());
      
      // 로그로 상태값 기록 출력
      logger.info("httpStatus : " + statusCode);
      
      // 404
      if(statusCode == HttpStatus.NOT_FOUND.value()) {
        //System.out.println("404");
        model.addAttribute("code", status.toString());
        model.addAttribute("msg", httpStatus.toString());
        model.addAttribute("timestamp", new Date());
        return ERROR_404_PAGE_PATH;
      }
      
      // 500
      if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
        return ERROR_500_PAGE_PATH;
      }
    }
    return ERROR_ETC_PAGE_PATH;
  }
}
