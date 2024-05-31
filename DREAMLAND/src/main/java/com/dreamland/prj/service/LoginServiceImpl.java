package com.dreamland.prj.service;

import java.io.File;
import java.sql.Date;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.mapper.EmployeeMapper;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MyJavaMailUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class LoginServiceImpl implements LoginService {

  private final EmployeeMapper employeeMapper;
  private final MyFileUtils myFileUtils;
  private final MyJavaMailUtils myJavaMailUtils;
  private final BCryptPasswordEncoder passwordEncoder;
  
  public LoginServiceImpl(EmployeeMapper employeeMapper, MyFileUtils myFileUtils
                        , MyJavaMailUtils myJavaMailUtils, BCryptPasswordEncoder passwordEncoder) {
    super();
    this.employeeMapper = employeeMapper;
    this.myFileUtils = myFileUtils;
    this.myJavaMailUtils = myJavaMailUtils;
    this.passwordEncoder = passwordEncoder;
  }
  
  // 파일 경로 메소드
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
  
  // 로그인
  @Override
  public EmployeeDto getEmployeeByEmail(String email) {
    
    EmployeeDto emp = employeeMapper.getEmployeeByEmail(email);
    return emp; 
  }
  
  // 마이페이지 수정
  @Override
  public void modifyUserInfo(MultipartFile profilePath
                           , MultipartFile signPath
                           , HttpServletRequest request) {
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
    
    EmployeeDto loginEmployee = employeeMapper.getEmployeeByEmail(email);
    PrincipalUser user = new PrincipalUser(loginEmployee);
    
    // 수정된 내용 세션 추가
    Authentication auth = new DBConnectionProvider(this).authenticate(new UsernamePasswordAuthenticationToken(user, "updateData", user.getAuthorities()));
    SecurityContextHolder.getContext().setAuthentication(auth);
  }
  
  // 비밀번호 수정
  @Override
  public int modifyPassword(HttpServletRequest request, PrincipalUser user) {
    // TODO Auto-generated method stub
    String beforePw = request.getParameter("currentPw");
    String changePw = passwordEncoder.encode(request.getParameter("newPw"));
    String email = user.getEmployeeDto().getEmail();
    
    // 현재 로그인한 사용자의 비밀번호와 입력한 값이 일치하는지 확인
    EmployeeDto emp = employeeMapper.getEmployeeByEmail(email);
    if(!passwordEncoder.matches(beforePw, emp.getPassword())) {
      System.out.println("해당 회원이 존재하지 않습니다");
      return 0;
    }
    
    employeeMapper.updatePassword(email, changePw);
    return employeeMapper.updatePassword(email, changePw);
  }
  
  // 이메일 체크
  @Override
  public ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params) {
    String email = params.get("email") + "";
    // 있으면 true(1) 없으면 false(0)
    boolean enableEmail = employeeMapper.getEmployeeByEmail(email) != null;
    return new ResponseEntity<>(Map.of("enableEmail", enableEmail), HttpStatus.OK);
  }
  
  // 임시비밀번호 전송
  @Override
  public ResponseEntity<Map<String, Object>> sendTempPw(Map<String, Object> params) {
    
    String code=  MySecurityUtils.getRandomString(8, true, true); 
    String email = (String)params.get("email");
    String title = "[DREAMLAND] 임시 비밀번호 전송";
    String contents = "<div>임시 비밀번호는 <strong>" + code +"</strong>입니다.";
    
    System.out.println(code);
    String encodePw = passwordEncoder.encode(code);
    int result = employeeMapper.updatePassword(email, encodePw);
    
    myJavaMailUtils.sendMail(email, title, contents);
    return new ResponseEntity<>(Map.of("result", result), HttpStatus.OK);
  }
}
