package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class FaqBoardServiceImpl implements FaqBoardService {
	private final FaqBoardMapper faqBoardMapper;
	private final MyPageUtils myPageUtils;
	
	public FaqBoardServiceImpl(FaqBoardMapper faqBoardMapper, MyPageUtils myPageUtils) {
		super();
		this.faqBoardMapper = faqBoardMapper;
		this.myPageUtils = myPageUtils;
	}
	@Override
	public int registerFaq(HttpServletRequest request) {
		String boardTitle = MySecurityUtils.getPreventXss(request.getParameter("boardTitle"));
		String boardContents = MySecurityUtils.getPreventXss(request.getParameter("boardContents"));
		int category =  Integer.parseInt(request.getParameter("category"));
		
		FaqBoardDto faq = FaqBoardDto.builder()
								.boardTitle(boardTitle)
								.boardContents(boardContents)
								.category(category)
							.build();
		return faqBoardMapper.insertFaqBoard(faq);
	}
	
	@Override
	public void loadFaqBoardList(Model model) {
		Map<String, Object> modelMap = model.asMap();
	  HttpServletRequest request = (HttpServletRequest) model.getAttribute("request");
	  
	  int total = faqBoardMapper.getFaqBoardCount();
	  
	  // 몇개씩 보이게 하는 거 선택사항 없게할건데, 바로 박는 거 어떻게 하지?
	  //Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
	  int display = 10;
	  
	  Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    myPageUtils.setPaging(total, display, page);
    
    String sort = "desc";
    // System.out.println("Sort Order: " + sort);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
    															 , "end"  , myPageUtils.getEnd()
    															 , "sort", sort);
	  
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("faqBoardList", faqBoardMapper.getFaqBoardList(map));
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath()+"/board/faq/list.do", sort, display));
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
	
}
