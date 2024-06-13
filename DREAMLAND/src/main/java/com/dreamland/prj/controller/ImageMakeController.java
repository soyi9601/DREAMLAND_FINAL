package com.dreamland.prj.controller;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.dreamland.prj.service.ImageService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ImageMakeController {
  
  @Autowired
  private ImageService imageService;

  @GetMapping("/sign/generate")
  public ResponseEntity<byte[]> generateImage(HttpServletRequest request) throws IOException {
    
    String empNoString = request.getParameter("empNo");
    int empNo = Integer.parseInt(empNoString);
    String empName = request.getParameter("empName");
    
    String fileName = empNoString + "-" + empName + "서명.png";
    
    try {
      byte[] imageBytes = imageService.generatePngImage(empName);
      HttpHeaders headers = new HttpHeaders();
      headers.add("Content-Type", "image/png");
      //headers.add("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode("generated_image.png", "UTF-8") + "\"")
      headers.add("Content-Disposition", "attachment; filename=\""+ URLEncoder.encode(fileName, "UTF-8")+ "\"");
      return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
    } catch (IOException e) {
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
