package com.dreamland.prj.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class ProductDto {
	
	private int productNo, price, productSctCd;
	private String productNM;
	private DepartmentDto department;
	
}
