package com.dreamland.prj.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class EmployeeDto {
	
	private int empNo, deptNo, posNo;
	private String empName, email, address, detailAddress, password, profilePath, signPath, mobile, role, postcode, deptName, posName;
	private double dayOff, usedDayOff;
	private Date birth, enterDate, resignDate;

}
