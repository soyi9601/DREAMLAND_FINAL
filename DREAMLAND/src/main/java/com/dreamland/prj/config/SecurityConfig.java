package com.dreamland.prj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.web.cors.CorsUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration 
@EnableWebSecurity 

public class SecurityConfig {
  
  private final AuthenticationFailureHandler customFailureHandler;
  
//  @Autowired
//  private DBConnectionProvider dbprovider;

  // 해당 메서드의 리턴되는 오브젝트를 IoC로 등록
  @Bean
  BCryptPasswordEncoder encodePwd() {
    return new BCryptPasswordEncoder();
  }
  
  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
    requestCache.setMatchingRequestParameterName(null);
    
    return http
        .csrf(csrf ->csrf.disable())
        .requestCache(request -> request
            .requestCache(requestCache))
        .authorizeHttpRequests(authorize -> authorize
            .requestMatchers("/loginPage").permitAll()
            .requestMatchers("/resources/**").permitAll() // "/resources/**" 경로에 대한 모든 사용자 허용
            .requestMatchers("/login/**", "/auth/**").permitAll()
            .requestMatchers("/WEB-INF/views/**").permitAll() // "/WEB-INF/views/**" 경로에 대한 모든 사용자 허용
            .requestMatchers("/auth/error").permitAll() 
            .requestMatchers(req->CorsUtils.isPreFlightRequest(req)).permitAll()
            
            .requestMatchers("/user/**").authenticated()  // 인증만 되면 들어갈 수 있는 주소
            .requestMatchers("/manager/**", "/").hasAnyRole("ADMIN", "USER")
            .requestMatchers("/depart/addDepart.page").hasRole("ADMIN")
            .requestMatchers("/depart/departAdmin.page").hasRole("ADMIN")
            .requestMatchers("/employee/**").hasRole("ADMIN")
            //.requestMatchers("/admin/**").hasRole("ADMIN")
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

        .exceptionHandling(exceptionHandle ->exceptionHandle
            .accessDeniedHandler(new CustomAccessDeniedHandler())
            )
          //.authenticationProvider(dbprovider) // DB와 연동하여 인증 처리
          .build(); // SecurityFilterChain 빌드 및 반환
 

  }
  
  
}
