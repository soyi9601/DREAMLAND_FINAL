package com.dreamland.prj.service;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Map;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.EmployeeMapper;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MyJavaMailUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Transactional
@Service
public class EmployeeServiceImpl implements EmployeService {

  private final EmployeeMapper employeeMapper;
  private final MyFileUtils myFileUtils;
  private final MyJavaMailUtils myJavaMailUtils;
  
  public EmployeeServiceImpl(EmployeeMapper employeeMapper, MyJavaMailUtils myJavaMailUtils
                          , MyFileUtils myFileUtils) {
    super();
    this.employeeMapper = employeeMapper;
    this.myJavaMailUtils = myJavaMailUtils;
    this.myFileUtils = myFileUtils;

  }
 
//  @Transactional(readOnly=true)
//  @Override
//  public ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params) {
//    boolean enableEmail = userMapper.getUserByMap(params) == null
//        && userMapper.getLeaveUserByMap(params) == null;
//    return new ResponseEntity<>(Map.of("enableEmail", enableEmail)
//        , HttpStatus.OK);
//  }

//  @Transactional(readOnly=true)
//  @Override
//  public ResponseEntity<Map<String, Object>> sendCode(Map<String, Object> params) {
//    
//    /*
//     * 구글 앱 비밀번호 설정 방법
//     * 1. 구글에 로그인한다.
//     * 2. [계정] - [보안]
//     * 3. [Google에 로그인하는 방법] - [2단계 인증]을 사용 설정한다.
//     * 4. 검색란에 "앱 비밀번호"를 검색한다.
//     * 5. 앱 이름을 "myapp"으로 작성하고 [만들기] 버튼을 클릭한다.
//     * 6. 16자리 비밀번호가 나타나면 복사해서 사용한다. (비밀번호 사이 공백은 모두 제거한다.)
//     */
//    
//    // 인증코드 생성
//    String code = MySecurityUtils.getRandomString(6, true, true);
//    
//    // 개발할 때 인증코드 찍어보기
//    System.out.println("인증코드 : " + code);
//    
//    // 메일 보내기
//    myJavaMailUtils.sendMail((String)params.get("email")
//        , "myapp 인증요청"
//        , "<div>인증코드는 <strong>" + code + "</strong>입니다.");
//    
//    // 인증코드 입력화면으로 보내주는 값
//    return new ResponseEntity<>(Map.of("code", code)
//        , HttpStatus.OK);
//    
//  }
  
  @Override
  public void addEmployee(MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response) {

    // 전달된 파라미터
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    String newProfilePath= null;
    if(profilePath != null && !profilePath.isEmpty()) {
      String uploadPath = myFileUtils.getUploadPath();
      
      File dir = new File(uploadPath);
      if(!dir.exists()) {
        dir.mkdirs();
      }
      String filesystemName = myFileUtils.getFilesystemName(profilePath.getOriginalFilename());
      File file = new File(dir, filesystemName);
      try {
        profilePath.transferTo(file);
      } catch(Exception e) {
        e.printStackTrace();
      }
      newProfilePath = uploadPath + "/" + filesystemName;
    } else {
      newProfilePath = "/c:/dreamland/upload/user-solid.png";
    }
    String password = encoder.encode(request.getParameter("empPw"));
    String name = request.getParameter("empName");
    Date birth = Date.valueOf(request.getParameter("birth"));
    Date enterDate = Date.valueOf(request.getParameter("enterDate"));
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    int deptNo = Integer.parseInt(request.getParameter("deptNo"));
    int posNo = Integer.parseInt(request.getParameter("posNo"));
    String role = request.getParameter("role");

    // Mapper 로 보낼 EmployeeDto 객체 생성
    EmployeeDto emp = EmployeeDto.builder()
                        .password(password) // 회원가입 되지만 시큐리티로 로그인을 할 수 없음. 이유는 패스워드가 암호화가 안되어있기 때문
                        .empName(name)
                        .birth(birth)
                        .enterDate(enterDate)
                        .mobile(mobile)
                        .email(email)
                        .deptNo(deptNo)
                        .posNo(posNo)
                        .role(role)
                        .profilePath(newProfilePath)
                      .build();
    
    // 회원 가입
    employeeMapper.insertEmployee(emp);  
    
  }
  
//  @Override
//  public void modifyUserInfo(MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response) {
//
//    String newProfilePath= null;
//    if(profilePath != null && !profilePath.isEmpty()) {
//      String uploadPath = myFileUtils.getUploadPath();
//      
//      File dir = new File(uploadPath);
//      if(!dir.exists()) {
//        dir.mkdirs();
//      }
//      String filesystemName = myFileUtils.getFilesystemName(profilePath.getOriginalFilename());
//      File file = new File(dir, filesystemName);
//      try {
//        profilePath.transferTo(file);
//      } catch(Exception e) {
//        e.printStackTrace();
//      }
//      newProfilePath = uploadPath + "/" + filesystemName;
//    } else {
//      newProfilePath = request.getParameter("beforeProfilePath");
//    }
//    
//    String empName = request.getParameter("empName");
//    Date birth = Date.valueOf(request.getParameter("birth"));
//    String mobile = request.getParameter("mobile");
//    String postcode = request.getParameter("postcode");
//    String address = request.getParameter("address");
//    String detailAddress = request.getParameter("detailAddress");
//    String email = request.getParameter("email");
//    
//    // Mapper 로 보낼 EmployeeDto 객체 생성
//    EmployeeDto emp = EmployeeDto.builder()
//                        .empName(empName)
//                        .birth(birth)
//                        .mobile(mobile)
//                        .postcode(postcode)
//                        .address(address)
//                        .detailAddress(detailAddress)
//                        .profilePath(newProfilePath)
//                        .email(email)
//                      .build();
//    
//    // 수정
//    employeeMapper.updateUserInfo(emp);
//    
//  }
  
//  @Override
//  public void leave(HttpServletRequest request, HttpServletResponse response) {
//    
//    try {
//
//      // 세션에 저장된 user 값 확인
//      HttpSession session = request.getSession();
//      UserDto user = (UserDto) session.getAttribute("user");
//      
//      // 세션 만료로 user 정보가 세션에 없을 수 있음
//      if(user == null) {
//        response.sendRedirect(request.getContextPath() + "/main.page");
//      }
//      
//      // 탈퇴 처리
//      int deleteCount = userMapper.deleteUser(user.getUserNo());
//      
//      // 탈퇴 이후 응답 만들기
//      response.setContentType("text/html");
//      PrintWriter out = response.getWriter();
//      out.println("<script>");
//      
//      // 탈퇴 성공
//      if(deleteCount == 1) {
//        
//        // 세션에 저장된 모든 정보 초기화
//        session.invalidate();  // SessionStatus 객체의 setComplete() 메소드 호출
//        
//        out.println("alert('탈퇴되었습니다. 이용해 주셔서 감사합니다.');");
//        out.println("location.href='" + request.getContextPath() + "/main.page';");
//        
//      // 탈퇴 실패
//      } else {
//        out.println("alert('탈퇴되지 않았습니다.');");
//        out.println("history.back();");
//      }
//      out.println("</script>");
//      
//    } catch (Exception e) {
//      e.printStackTrace();
//    }
//    
//  }
//  
//  @Transactional(readOnly=true)
//  @Override
//  public String getRedirectURLAfterSignin(HttpServletRequest request) {
//    
//    // Sign In 페이지 이전의 주소가 저장되어 있는 Request Header 의 referer 값 확인
//    String referer = request.getHeader("referer");
//    
//    // referer 로 돌아가면 안 되는 예외 상황 (아이디/비밀번호 찾기 화면, 가입 화면 등)
//    String[] excludeURLs = {"/findId.page", "/findPw.page", "/signup.page", "/upload/edit.do"};
//    
//    // Sign In 이후 이동할 url
//    String url = referer;
//    if(referer != null) {
//      for(String excludeURL : excludeURLs) {
//        if(referer.contains(excludeURL)) {
//          url = request.getContextPath() + "/main.page";
//          break;
//        }
//      }
//    } else {
//      url = request.getContextPath() + "/main.page";
//    }
//    
//    return url;
//    
//  }
//  

}
