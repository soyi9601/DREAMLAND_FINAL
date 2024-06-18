package com.dreamland.prj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.web.cors.CorsUtils;

import lombok.RequiredArgsConstructor;

/******************************************
 * 
 * Spring Security 설정
 * 작성자 : 고은정
 * 
 * ****************************************/

@RequiredArgsConstructor
@Configuration 
@EnableWebSecurity 

public class SecurityConfig {
  
  private final AuthenticationFailureHandler customFailureHandler;
  
  // 비밀번호 암호화
  @Bean
  BCryptPasswordEncoder encodePwd() {
    return new BCryptPasswordEncoder();
  }
  
  // 권한별 접근 페이지 설정
  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
    requestCache.setMatchingRequestParameterName(null);
    
    return http
        .csrf(csrf ->csrf.disable())
        .requestCache(request -> request
            .requestCache(requestCache))
        .authorizeHttpRequests(authorize -> authorize
            
            /* 권한 없이 모두 접근 가능 */
            .requestMatchers("/loginPage").permitAll()
            .requestMatchers("/resources/**").permitAll() // "/resources/**" 경로에 대한 모든 사용자 허용
            .requestMatchers("/login/**", "/auth/**").permitAll()
            .requestMatchers("/WEB-INF/views/**").permitAll() // "/WEB-INF/views/**" 경로에 대한 모든 사용자 허용
            //.requestMatchers("/auth/error").permitAll() 
            .requestMatchers(req->CorsUtils.isPreFlightRequest(req)).permitAll()
            
            /* 인증만 되면 접근할 수 있는 페이지 */
            .requestMatchers("/user/**").authenticated()  // 인증만 되면 들어갈 수 있는 주소
            
            /* 관리자만 가능*/
            .requestMatchers("/depart/addDepart.page").hasRole("ADMIN")
            .requestMatchers("/depart/departAdmin.page").hasRole("ADMIN")
            .requestMatchers("/board/faq/write.page").hasRole("ADMIN")
            .requestMatchers("/board/notice/write.page").hasRole("ADMIN")
            .requestMatchers("/employee/**").hasRole("ADMIN")
            
            /* 유저(직원)만 가능 */
            .requestMatchers("/approval/appWrite").hasAnyRole("USER", "MANAGER")
            
            /* 매니저만 가능 */
            .requestMatchers("/sales/productreg.page").hasRole("MANAGER")
            .requestMatchers("/sales/salesreg.page").hasRole("MANAGER")
            
            /* 이외의 요청들은 인증이 되어야 함 */
            .anyRequest().authenticated()) 
        .formLogin(formLogin -> formLogin
            .loginPage("/loginPage")
            .loginProcessingUrl("/login") // login 주소가 호출이 되면 시큐리티가 낚아채서 대신 로그인을 진행해준다.
            .failureHandler(customFailureHandler)
            .defaultSuccessUrl("/",true)  // 999 오류 해결부분
            )
        .logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/login?logout")
            .invalidateHttpSession(true)
            .deleteCookies("JSESSIONID").permitAll()
         )
        .sessionManagement((auth) -> auth
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)   // 로그인과 같은 사용자활동으로 세션이 생성되지 않았다면 세션타임아웃 발생하지 않음
            .invalidSessionUrl("/loginPage") // 유효하지 않은 세션이면 로그인페이지로 이동
            .sessionFixation().changeSessionId()  // 로그인시 동일한 세션에 대한 id변경(기존 세션은 동일하지만 유저가 발급받는 세션ID가 변경됨)
            .maximumSessions(1).expiredUrl("/loginPage"))  // 사용자별 세션은 1개만 사용 가능

        .exceptionHandling(exceptionHandle ->exceptionHandle
            .accessDeniedHandler(new CustomAccessDeniedHandler())
            )
          //.authenticationProvider(dbprovider) // DB와 연동하여 인증 처리
          .build(); // SecurityFilterChain 빌드 및 반환
 

  }
  
  
}
