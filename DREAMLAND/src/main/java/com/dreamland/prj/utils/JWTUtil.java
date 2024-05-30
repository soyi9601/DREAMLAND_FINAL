package com.dreamland.prj.utils;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Jwts;
import jakarta.servlet.http.Cookie;

@Component
public class JWTUtil {

  private SecretKey secretKey;

  public JWTUtil(@Value("${spring.jwt.secret}")String secret) {

    this.secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
  }

  public String getUsername(String token) {

    return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("username", String.class);
  }

  public String getRole(String token) {

    return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("role", String.class);
  }

  public Boolean isExpired(String token) {

    return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
  }

  public String createJwt(String category, String username, String role, Long expiredMs) {

    return Jwts.builder()
              .claim("category", category)
              .claim("username", username)
              .claim("role", role)
              .issuedAt(new Date(System.currentTimeMillis()))
              .expiration(new Date(System.currentTimeMillis() + expiredMs))
              .signWith(secretKey)
              .compact();
  }
  
  // 토큰 판단용 
  public String getCategory(String token) {
    return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("category", String.class);
  }
  
  // 쿠키 생성
  public Cookie createCookie(String key, String value) {
    Cookie cookie = new Cookie(key, value);
    cookie.setMaxAge(24*60*60);
    // cookie.setSecure(true);
    // cookie.setPath("/");
    cookie.setHttpOnly(true);
    
    return cookie;
  }
    
}
