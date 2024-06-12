package com.dreamland.prj.dto;


import java.util.List;

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
	private String productNM, delyn;
	private DepartmentDto department;
  private List<String> productNoList;
}
