package com.dreamland.prj.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
  
  @Override
  public void addViewControllers(ViewControllerRegistry registry){
    registry.addViewController("/").setViewName("index");
    registry.addViewController("/index").setViewName("index");
    registry.addViewController("/admin").setViewName("admin");
    registry.addViewController("/user/mypage").setViewName("user/mypage");
    registry.addViewController("/manager").setViewName("manager");
    registry.addViewController("/login").setViewName("login/loginPage");
    registry.addViewController("/employee/add").setViewName("employee/addEmployee");
  }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/resources/**")
         .addResourceLocations("classpath:/static/");
	    registry.addResourceHandler("/upload/**")
         .addResourceLocations("file:///upload/");
	    registry.addResourceHandler("/blog/**")
         .addResourceLocations("file:///blog/");
	}

}