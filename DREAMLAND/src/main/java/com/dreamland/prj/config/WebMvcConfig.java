package com.dreamland.prj.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

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