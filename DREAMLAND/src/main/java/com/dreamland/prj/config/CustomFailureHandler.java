package com.dreamland.prj.config;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/******************************************
 * 
 * 로그인 예외처리
 * 작성자 : 고은정
 * 
 * ****************************************/

@Component
public class CustomFailureHandler extends SimpleUrlAuthenticationFailureHandler{
  
  @Override
  public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
      AuthenticationException exception) throws IOException, ServletException {
    String errorMessage;
    if (exception instanceof BadCredentialsException) {
      errorMessage = "아이디 또는 비밀번호가 맞지 않습니다.";
    } else {
      errorMessage = "알 수 없는 이유로 로그인에 실패하였습니다. 관리자에게 문의하세요.";
    }
    errorMessage = URLEncoder.encode(errorMessage, "UTF-8");
    setDefaultFailureUrl("/auth/login?error=true&exception=" + errorMessage);
    super.onAuthenticationFailure(request, response, exception);
  }
}
