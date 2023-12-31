package semi.project.jsnr.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import semi.project.jsnr.animal.model.service.AnimalService;
import semi.project.jsnr.animal.model.vo.Image;
import semi.project.jsnr.board.model.exception.BoardException;
import semi.project.jsnr.board.model.service.BoardService;
import semi.project.jsnr.board.model.vo.Board;
import semi.project.jsnr.common.Pagination;
import semi.project.jsnr.common.model.vo.PageInfo;
import semi.project.jsnr.jibsa.model.service.JibsaService;
import semi.project.jsnr.jibsa.model.vo.Jibsa;
import semi.project.jsnr.jibsa.model.vo.JibsaProfile;
import semi.project.jsnr.member.model.vo.Member;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private JibsaService jService;
	
	@RequestMapping("review_Main.bo")
	public String reviewBoardList(@RequestParam(value="page", required=false) Integer currentPage, 
			@RequestParam(value="value", required=false) String value, HttpSession session,
			Model model) {
		
		if(currentPage == null) {
			currentPage = 1;
		}
		
		int listCount = bService.getListCount(1);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		ArrayList<Board> list = bService.reviewBoardList(pi);
		
		ArrayList<Image> imgList = new ArrayList<Image>();
		for(Board b : list) {
			Image image = bService.selectAnimalImage(b.getMemberNo());
			imgList.add(image);
		}
			
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("imgList", imgList);
			model.addAttribute("value", value);
			return "review_Main"; 
			
		} else {
			throw new BoardException("게시글 조회를 실패하였습니다.");
		}
	}
	
	@GetMapping("jibsa_List.bo")
	public String jibsaList(@RequestParam(value="page", required=false) Integer page,
							@RequestParam(value="searchType", required=false) Integer searchType,
							Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int selectType = 3;
		if(searchType != null) {
			selectType = searchType;
		}

		int listCount = bService.getJibsaListCount(selectType);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		
		ArrayList<JibsaProfile> jpList = bService.selectJibsaProfileList(pi, selectType);
		
		ArrayList<Image> iList = bService.selectJibsaImageList();
		for(int i = 0; i < iList.size(); i++) {
			for(int j = 0; j < jpList.size(); j++) {
				if(iList.get(i).getMemberNo() == jpList.get(j).getMemberNo()) {
					jpList.get(j).setImage(iList.get(i));
				}
			}
		}
		
		if(jpList != null) {
			model.addAttribute("searchType", searchType);
			model.addAttribute("pi", pi);
			model.addAttribute("jpList", jpList);
		}
		return "jibsa_List";
	}
	
	@GetMapping("jibsa_Detail.bo")
	public String selectProfile(@RequestParam(value="page", required=false) Integer page,
								@RequestParam("mId") int mId,
								HttpSession session,
								Model model) {
		Jibsa jibsa = bService.getJibsaInfo(mId);
		JibsaProfile jp = bService.getJibsaProfile(mId);
		Image image = bService.selectJibsaImage(mId);
		
		String[] arr = new String[7];
		for(int i = 0; i < 7; i++) {
			arr[i] = jibsa.getAvailableHour().split(",")[i];
		}
		jp.setAvailableHourArr(arr);
		
		
		if(jibsa != null) {
			model.addAttribute("image", image);
			model.addAttribute("page", page);
			model.addAttribute("jibsa", jibsa);
			model.addAttribute("jp", jp);
			return "jibsa_Detail";
		} else {
			throw new BoardException("게시글 조회를 실패하였습니다.");
		}
	}

	
	@RequestMapping("search.bo")
	public String searchListCount(@RequestParam(value="page", required=false) Integer currentPage, 
			HttpServletRequest request, Model model) {
		
		if(currentPage == null) {
			currentPage = 1;
		}
		
		
		String condition = request.getParameter("condition");
		String value = request.getParameter("value");
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("condition", condition);
		map.put("value", value);
		
		int listCount = bService.getSearchListCount(map);
		
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		ArrayList<Board> list = bService.selectSearchList(map, pi);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("condition", condition);
			model.addAttribute("value", value);
		
			return "review_Main";
		} else {
			throw new BoardException("리뷰 검색을 실패하였습니다.");
		}
	}
	
	@RequestMapping("review_Detail.bo")
	public ModelAndView reviewDetail(@RequestParam(value="page", required=false) int page,
			ModelAndView mv, HttpSession session, 
			@RequestParam(value="mId", required=false) int mId, 
			@RequestParam(value="userName", required=false) String userName) {
		
		Member m = (Member)session.getAttribute("loginUser");
		String login = null;
		if(m != null) {
			login = m.getMemberName();
		}  
		boolean yn = false;
		if(!userName.equals(login)) {
			yn = true;
		}
		
		
		
		Board b = bService.reviewDetail(mId, yn);	
		 
		Board list = bService.selectReply(mId);
		Image image = bService.selectAnimalImage(b.getMemberNo());
		if(b != null) {
			mv.addObject("page", page);
			mv.addObject("b", b);
			mv.addObject("list", list);
			mv.addObject("image", image);
			mv.setViewName("review_Detail");
			return mv;
		} else {
			throw new BoardException("게시글 상세보기를 실패하였습니다.");
		}
		
	}
	
	
	@RequestMapping("updateReply.bo")
	public void updateReply(@ModelAttribute Board b, 
			HttpServletResponse response) {
		bService.updateReply(b);
		Board list = bService.selectReply(b.getMemberNo());
		
		response.setContentType("application/json; charset=UTF-8");
		
		GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
		Gson gson = gb.create();
		String json = gson.toJson(b);
		
	    try {
	        response.getWriter().write(json);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	@RequestMapping("deleteReply.bo")
	public void  deleteReply(@ModelAttribute Board b, 
			HttpServletResponse response) {
		bService.deleteReply(b);
		Board list = bService.selectReply(b.getMemberNo());
		
		response.setContentType("application/json; charset=UTF-8");
		
		GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
		Gson gson = gb.create();
		String json = gson.toJson(b);
		    try {
		        response.getWriter().write(json);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
	}	
	
	@RequestMapping("jibsa_Review.js")
	public String jibsaReview(@RequestParam(value="page", required=false) Integer currentPage, 
			Model model, HttpSession session, HttpServletResponse response) {
		
		if(currentPage == null) {
			currentPage = 1;
		}
		Member m = (Member)session.getAttribute("loginUser");
		String jibsaName = m.getMemberName();
		String login = null;
		if(m != null) {
			login = jibsaName;
		}  
		boolean yn = false;
		if(!jibsaName.equals(login)) {
			yn = true;
		}
		ArrayList<Board> b = bService.jibsaReview(jibsaName, yn);
//		
//		int listCount = bService.jibsaReviewCount(jibsaName, 1);
		
//		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
//		ArrayList<Board> list = bService.jibsaReview(jibsaName);
		 
		if(b != null) {
//			model.addAttribute("pi", pi);
			model.addAttribute("b", b);
//			model.addAttribute("list", list);
			return "jibsa_Review";
		} else {
			throw new BoardException("게시글 조회를 실패하였습니다.");
		}
	}
	
	@GetMapping("jibsaReviewDateSearch.js")
	public String jibsaReviewDateSearch(HttpServletRequest request, HttpSession session, Model model, @RequestParam("from") String from,
	@RequestParam("to") String to){
		
		Member m = (Member)session.getAttribute("loginUser");
		String jibsaName = m.getMemberName();
		
		String login = null;
		if(m != null) {
			login = jibsaName;
		}  
		boolean yn = false;
		if(!jibsaName.equals(login)) {
			yn = true;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("from", from);
		map.put("to", to);
		map.put("jibsaName", jibsaName);
		
		List<Object> count = bService.jibsaPageReviewCount2(map);
		ArrayList<Board> b = bService.jibsaReviewDateSearch(map, yn);
		
		
		if(b != null) {
			model.addAttribute("from", from);
			model.addAttribute("to", to);
			model.addAttribute("count", count);
			model.addAttribute("b", b);
			return "jibsa_Review";
		} else {
			throw new BoardException("리뷰 검색을 실패하였습니다.");
		}
	}
	@RequestMapping("reviewList.bo")
	public String reviewList(@RequestParam("sortBy") String sortBy, @RequestParam(value="page", required=false) Integer currentPage, 
			HttpServletRequest request, Model model) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sortBy", sortBy);
	 
		if(currentPage == null) {
			currentPage = 1;
		}
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int listCount = bService.sortListCount(map); 
		
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
	 
		ArrayList<Board> list = bService.reviewList(map, pi);
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("sortBy", sortBy);
			return "review_Main";
		} else {
			throw new BoardException("리뷰 정렬을 실패하였습니다.");
		}
	  
	}
	
//	@RequestMapping("member_Review_Detail.me")
//	public String member_Review_Detail(HttpSession session, Model model, @RequestParam(value="matchingNo", required=false) Integer matchingNo) {
//		
//		Member m = (Member)session.getAttribute("loginUser");
//		String userName = m.getMemberName();
//		String login = null;
//		if(m != null) {
//			login = userName;
//		}  
//		boolean yn = false;
//		if(!userName.equals(login)) {
//			yn = true;
//		}
//		
//		ArrayList<Board> b = bService.member_Review_Detail(userName);
//		
//		if(b != null) {
//			model.addAttribute("b", b);
//			model.addAttribute("matchingNo", matchingNo);
//			return "member_Review_Detail";
//		} else {
//			throw new BoardException("게시글 조회를 실패하였습니다.");
//		}
//		
//	}
//	
	
//	@PostMapping("member_Review_Detail.me")
//	public String member_Review_Detail(HttpSession session, @ModelAttribute Board b, @RequestParam("page") int page, Model model) {
//		
//		int result = bService.member_Review_Detail(b);
//		if(result > 0) {
//			model.addAttribute("mId", b.getMatchingNo());
//			model.addAttribute("writer", ((Member)session.getAttribute("loginUser")).getMemberName());
//			model.addAttribute("page", page);
//			return "member_Review_Detail";
//		} else {
//			throw new BoardException("게시글 수정을 실패하였습니다.");
//		}	
//		
//	}
	
	

}

