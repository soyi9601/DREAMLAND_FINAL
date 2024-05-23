package com.dreamland.prj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration 
@EnableWebSecurity 

public class SecurityConfig {

  // 해당 메서드의 리턴되는 오브젝트를 IoC로 등록
  @Bean
  BCryptPasswordEncoder encodePwd() {
    return new BCryptPasswordEncoder();
  }
  
  private final AuthenticationFailureHandler customFailureHandler;
  
  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
    requestCache.setMatchingRequestParameterName(null);
    
    return http
        .csrf(csrf ->csrf.disable())
        .requestCache(request -> request
            .requestCache(requestCache))
        .authorizeHttpRequests(authorize -> authorize
            .requestMatchers("/user/**").authenticated()  // 인증만 되면 들어갈 수 있는 주소
            .requestMatchers("/manager/**", "/").hasAnyRole("ADMIN", "USER")
            //.requestMatchers("/employee/**").hasRole("ADMIN")
            //.requestMatchers("/admin/**").hasRole("ADMIN")
            .anyRequest().permitAll()) 
        .formLogin(formLogin -> formLogin
            .loginPage("/login")
            .loginProcessingUrl("/login") // login 주소가 호출이 되면 시큐리티가 낚아채서 대신 로그인을 진행해준다.
            .failureHandler(customFailureHandler)
            .defaultSuccessUrl("/")
            ) 
            
        
        .build();
  }

  
}
