package com.dreamland.prj.dto;

import java.sql.Date;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class EmployeeDto {
	
	private int empNo, dayOff, deptNo, posNo, id;
	private String empName, email, address, detailAddress, password, profilePath, sighPath, mobile, role;
	private Date birth, enterDate, resignDate;

}
