package com.dreamland.prj.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
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
	
	private int empNo, dayOff, deptNo, posNo;
	private String empName, email, address, detailAddress, password, profilePath, signPath, mobile, role, postcode;
	private Date birth, enterDate, resignDate;

}
