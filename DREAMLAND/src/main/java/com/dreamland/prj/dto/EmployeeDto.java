package com.dreamland.prj.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class EmployeeDto {
	
	private int empNo, mobile, dayOff, deptNo, posNo, permission, id;
	private String empName, email, address, detailAddress, password, profilePath, sighPath;
	private Date birth, enterDate, resignDate;


}