package com.dreamland.prj.service;

import java.io.File;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PositionDto;
import com.dreamland.prj.mapper.EmployeeMapper;
import com.dreamland.prj.utils.MyFileUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Transactional
@Service
public class EmployeeServiceImpl implements EmployeeService {

  private final EmployeeMapper employeeMapper;
  private final MyFileUtils myFileUtils;
  
  public EmployeeServiceImpl(EmployeeMapper employeeMapper, MyFileUtils myFileUtils) {
    super();
    this.employeeMapper = employeeMapper;
    this.myFileUtils = myFileUtils;

  }
  
  @Override
  public void getDeptAndPos(Model model) {
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    List<DepartmentDto> deptList = employeeMapper.getDeptList();
    List<PositionDto> posList = employeeMapper.getPosList();
    //Map<String, Object> deptList = Map.of("deptList", employeeMapper.getDeptList());
    //Map<String, Object> posList = Map.of("posList", employeeMapper.getPosList());
    model.addAttribute("deptList", deptList);
    model.addAttribute("posList", posList);
    
  }
  
  private String filePath(MultipartFile filePath) {
    
    String newFilePath = null;
    
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
      newFilePath = "";
    }
    return newFilePath;
  }
  
  @Override
  public void addEmployee(MultipartFile profilePath
                        , HttpServletRequest request, HttpServletResponse response) {

    // 전달된 파라미터
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    String newProfilePath = null;
    
    newProfilePath = filePath(profilePath);
    
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
  

}
