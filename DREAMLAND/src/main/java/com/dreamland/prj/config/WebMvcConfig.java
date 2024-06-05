package com.dreamland.prj.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
  //application.properties 파일의 설정값 저장
  @Value("${service.file.uploadurl}")
  public String UP_DIR;
  
  @Override
  public void addViewControllers(ViewControllerRegistry registry){
    registry.addViewController("/index").setViewName("index");
    registry.addViewController("/").setViewName("index");
    registry.addViewController("/admin").setViewName("admin");
    
    registry.addViewController("/user/mypage").setViewName("user/mypage");
    registry.addViewController("/user/modifyPassword").setViewName("user/modifyPassword");
    registry.addViewController("/user/receiveBox").setViewName("message/receiveBox");
    registry.addViewController("/user/sendBox").setViewName("message/sendBox");
    registry.addViewController("/user/saveBox").setViewName("message/saveBox");
    registry.addViewController("/user/removeBox").setViewName("message/removeBox");
    registry.addViewController("/user/sendMessage").setViewName("message/sendMessage");
    
    registry.addViewController("/manager").setViewName("manager");
    registry.addViewController("/auth/error").setViewName("error/errorPage");
    registry.addViewController("/loginPage").setViewName("login/loginPage");
    registry.addViewController("/login/tempPassword").setViewName("login/temporaryPassword");
    registry.addViewController("/employee/add").setViewName("employee/addEmployee");
  }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
      registry.addResourceHandler("/resources/**")
         .addResourceLocations("classpath:/static/");
      registry.addResourceHandler(UP_DIR+"**")
         .addResourceLocations("file://" + UP_DIR);
  //    registry.addResourceHandler(UP_DIR+"blog/**")
  //       .addResourceLocations("file://" + UP_DIR);
  }

}