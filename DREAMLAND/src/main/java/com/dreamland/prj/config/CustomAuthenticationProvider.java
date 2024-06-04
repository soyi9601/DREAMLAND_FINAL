package com.dreamland.prj.config;

import org.springframework.stereotype.Component;

import com.dreamland.prj.service.LoginService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationProvider{
  

  private final LoginService loginService;
 

}
