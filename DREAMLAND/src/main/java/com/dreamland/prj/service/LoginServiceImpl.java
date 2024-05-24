package com.dreamland.prj.service;

import java.io.File;
import java.sql.Date;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.EmployeeMapper;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MyJavaMailUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Transactional
@Service
public class LoginServiceImpl implements LoginService {

  private final EmployeeMapper employeeMapper;
  private final MyFileUtils myFileUtils;
  private final MyJavaMailUtils myJavaMailUtils;
  
  public LoginServiceImpl(EmployeeMapper employeeMapper, MyFileUtils myFileUtils, MyJavaMailUtils myJavaMailUtils) {
    super();
    this.employeeMapper = employeeMapper;
    this.myFileUtils = myFileUtils;
    this.myJavaMailUtils = myJavaMailUtils;
  }

  // 로그인
  @Override
  public EmployeeDto getEmployeeByEmail(String email) {
    
    EmployeeDto emp = employeeMapper.getEmployeeByMap(email);
    return emp; 
  }
  
  private String filePath(MultipartFile filePath, String beforePath) {
    
    String newFilePath = null;
    String beforeFilePath = beforePath;
    
    if(filePath != null && !filePath.isEmpty()) {
      String uploadPath = myFileUtils.getUploadPath();
      
      File dir = new File(uploadPath);
      if(!dir.exists()) {
        dir.mkdirs();
      }
      String filesystemName = myFileUtils.getFilesystemName(filePath.getOriginalFilename());
      File file = new File(dir, filesystemName);
      try {
        filePath.transferTo(file);
      } catch(Exception e) {
        e.printStackTrace();
      }
      newFilePath = uploadPath + "/" + filesystemName;
    } else {
      newFilePath = beforePath;
    }
    return newFilePath;
  }
  
  // 마이페이지 수정
  @Override
  public void modifyUserInfo(MultipartFile profilePath
                           , MultipartFile signPath
                           , HttpServletRequest request, HttpServletResponse response) {
    String newProfilePath= null;
    String newSignPath = null;
    
    newProfilePath = filePath(profilePath, request.getParameter("beforeProfilePath"));
    newSignPath = filePath(signPath, request.getParameter("beforeSignPath"));
    
    
    String empName = request.getParameter("empName");
    Date birth = Date.valueOf(request.getParameter("birth"));
    String mobile = request.getParameter("mobile");
    String postcode = request.getParameter("postcode");
    String address = request.getParameter("address");
    String detailAddress = request.getParameter("detailAddress");
    String email = request.getParameter("email");
    
    // Mapper 로 보낼 EmployeeDto 객체 생성
    EmployeeDto emp = EmployeeDto.builder()
                        .empName(empName)
                        .birth(birth)
                        .mobile(mobile)
                        .postcode(postcode)
                        .address(address)
                        .detailAddress(detailAddress)
                        .profilePath(newProfilePath)
                        .signPath(newSignPath)
                        .email(email)
                      .build();
    
    // 수정
    employeeMapper.updateUserInfo(emp);
    
    EmployeeDto loginEmployee = employeeMapper.getEmployeeByMap(email);
    
    Authentication auth = new DBConnectionProvider(this).authenticate(new UsernamePasswordAuthenticationToken(loginEmployee, "updateData", loginEmployee.getAuthorities()));
    SecurityContextHolder.getContext().setAuthentication(auth);
  }
}
