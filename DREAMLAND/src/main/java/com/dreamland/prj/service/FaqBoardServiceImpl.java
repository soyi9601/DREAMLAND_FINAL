package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyBoardPageUtils;
import com.dreamland.prj.utils.MyPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class FaqBoardServiceImpl implements FaqBoardService {
	private final FaqBoardMapper faqBoardMapper;
	private final MyBoardPageUtils myBoardPageUtils;
	
	public FaqBoardServiceImpl(FaqBoardMapper faqBoardMapper, MyBoardPageUtils myBoardPageUtils) {
		super();
		this.faqBoardMapper = faqBoardMapper;
		this.myBoardPageUtils = myBoardPageUtils;
	}
	@Override
	public int registerFaq(HttpServletRequest request) {
		String boardTitle = MySecurityUtils.getPreventXss(request.getParameter("boardTitle"));
		String boardContents = MySecurityUtils.getPreventXss(request.getParameter("boardContents"));
		int category =  Integer.parseInt(request.getParameter("category"));
		int empNo = Integer.parseInt(request.getParameter("empNo"));
		
		EmployeeDto emp = new EmployeeDto();
		emp.setEmpNo(empNo);
		
		FaqBoardDto faq = FaqBoardDto.builder()
								.boardTitle(boardTitle)
								.boardContents(boardContents)
								.category(category)
								.employee(emp)
							.build();
		return faqBoardMapper.insertFaqBoard(faq);
	}
	
	@Transactional(readOnly = true)
	@Override
	public void loadFaqBoardList(Model model) {

	  
	
	  Map<String, Object> modelMap = model.asMap();
	  HttpServletRequest request = (HttpServletRequest) model.getAttribute("request");
	  
	  int total = faqBoardMapper.getFaqBoardCount();
	  
	  Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
	  int display = 10;
	  
	  Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
	  int page = Integer.parseInt(optPage.orElse("1"));
    
	  myBoardPageUtils.setPaging(total, display, page);
    
    String sort = "desc";
    
    Map<String, Object> map = Map.of("begin", myBoardPageUtils.getBegin()
    															 , "end"  , myBoardPageUtils.getEnd()
    															 , "sort", sort);
	  
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("faqBoardList", faqBoardMapper.getFaqBoardList(map));
    model.addAttribute("paging", myBoardPageUtils.getPaging(request.getContextPath()+"/board/faq/list.do"
    				  , sort
    				  , display));
    model.addAttribute("display", display);
    model.addAttribute("page", page);
	}
	
	
	@Override
	public FaqBoardDto getFaqBoardByNo(int boardNo) {
		return faqBoardMapper.getFaqBoarByNo(boardNo);
	}
	
	@Override
	public int modifyFaqBoard(FaqBoardDto faqBoardDto) {
		return faqBoardMapper.updateFaqBoard(faqBoardDto);
	}
	
	@Override
	public int removeFaqBoard(int faqNo) {
		return faqBoardMapper.deleteFaqBoard(faqNo);
	}
	
	// category하는중
	@Transactional(readOnly = true)
	@Override
	public void loadFaqCategoryList(HttpServletRequest request, Model model) {
		
		String category = request.getParameter("category");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		
		int total = faqBoardMapper.getSortCount(map);
		
		int display = 10;
		
		//String sort = "desc";
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myBoardPageUtils.setPaging(total, display, page);
	    
		map.put("begin", myBoardPageUtils.getBegin());
		map.put("end", myBoardPageUtils.getEnd());
		
		// 카테고리 목록 가져오기
		List<FaqBoardDto> faqList = faqBoardMapper.getSortList(map);
		
		System.out.println(map);
		System.out.println(faqList);
		
		model.addAttribute("beginNo", total -(page - 1) * display);
		model.addAttribute("faqBoardList", faqList);
		model.addAttribute("paging", myBoardPageUtils.getPaging(request.getContextPath() + "/board/faq/sort.do"
				    	 , ""
				    	 , 10
				    	 , "category="+category));

	}
	
	@Transactional(readOnly = true)
	@Override
	public void loadFaqSearchList(HttpServletRequest request, Model model) {
		
		String category = request.getParameter("category");
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("column", column);
		map.put("category", category);
		map.put("query", query);
		
		int total = faqBoardMapper.getSearchCount(map);
		
		System.out.println(total);
		System.out.println(map);
		System.out.println(category);
		
		
		int display = 10;
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myBoardPageUtils.setPaging(total, display, page);
	    
		map.put("begin", myBoardPageUtils.getBegin());
		map.put("end", myBoardPageUtils.getEnd());
		
		// 검색 목록 가져오기
		List<FaqBoardDto> faqList = faqBoardMapper.getSearchList(map);
		
		model.addAttribute("beginNo", total -(page - 1) * display);
		model.addAttribute("faqBoardList", faqList);
		model.addAttribute("paging", myBoardPageUtils.getPaging(request.getContextPath() + "/board/faq/search.do"
				    	 , ""
				    	 , 10
				    	 , "category="+category + "&query="+query));
	}
	
	
}
