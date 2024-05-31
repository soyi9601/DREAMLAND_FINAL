package com.dreamland.prj.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dreamland.prj.service.RefreshServiceImpl;
import com.dreamland.prj.utils.JWTUtil;

import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// @RestController 사용 가능 (controller + responsebody 합친것)
@Controller
@ResponseBody
public class ReissueController {
  
  private final JWTUtil jwtUtil;
  private final RefreshServiceImpl refreshService;

  public ReissueController(JWTUtil jwtUtil, RefreshServiceImpl refreshService) {

    this.jwtUtil = jwtUtil;
    this.refreshService = refreshService;
  }
  
  @PostMapping("/reissue")
  public ResponseEntity<?> reissue(HttpServletRequest request, HttpServletResponse response){
    
    // 이 안에 있는 코드들을 service 로 빼는걸 추천!
    // refresh token 가져오기
    String refresh = null;
    Cookie[] cookies = request.getCookies();
    for(Cookie cookie : cookies) {
      if(cookie.getName().equals("refresh")) {
        refresh = cookie.getValue();
      }
    }
    
    // refresh token 이 null 일 때
    if (refresh == null) {
      return new ResponseEntity<>("refresh token null", HttpStatus.BAD_REQUEST);
    }
    
    // refresh token 만료 체크
    try {
      jwtUtil.isExpired(refresh);
    } catch (ExpiredJwtException e) {
      
      return new ResponseEntity<>("refresh token expired", HttpStatus.BAD_REQUEST);
    }
    
    // 토큰이 refresh 인지 확인
    String category = jwtUtil.getCategory(refresh);
    
    if(!category.equals("refresh")) {
      
      return new ResponseEntity<>("invalid refresh token", HttpStatus.BAD_REQUEST);
    }
    
    // DB에 저장되어 있는지 확인
    boolean isExist = refreshService.searchRefreshToken(refresh) > 0;
    
    if(!isExist) {
      return new ResponseEntity<>("invalid refresh token", HttpStatus.BAD_REQUEST);
    }
    
    String username = jwtUtil.getUsername(refresh);
    String role = jwtUtil.getRole(refresh);
    
    // 새로운 access/refresh token 생성
    String newAccess = jwtUtil.createJwt("access", username, role, 600000L);      // 10분
    String newRefresh = jwtUtil.createJwt("refresh", username, role, 86400000L);  // 24시간
    
    // Refresh 토큰 저장, DB 에 기존의 Refresh 토큰 삭제 후 새 Refresh 토큰 저장
    refreshService.deleteByRefresh(refresh);
    addRefreshDto(username, newRefresh, 86400000L);
    // 응답
    response.setHeader("access", newAccess);
    response.addCookie(jwtUtil.createCookie("refresh", newRefresh));
    
    return new ResponseEntity<>(HttpStatus.OK);
  }
  
  private void addRefreshDto(String username, String refresh, Long expiredMs) {

    // 만료 일자 등록
    Date date = new Date(System.currentTimeMillis() + expiredMs);
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String refDate = sdf.format(date);
    
    refreshService.addRefreshToken(username, refresh, refDate);
}
}
