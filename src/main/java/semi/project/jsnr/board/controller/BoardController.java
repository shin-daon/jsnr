package semi.project.jsnr.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import semi.project.jsnr.board.model.exception.BoardException;
import semi.project.jsnr.board.model.service.BoardService;
import semi.project.jsnr.board.model.vo.Board;
import semi.project.jsnr.common.Pagination;
import semi.project.jsnr.common.model.vo.PageInfo;
import semi.project.jsnr.jibsa.model.vo.Jibsa;
import semi.project.jsnr.jibsa.model.vo.JibsaProfile;
import semi.project.jsnr.member.model.vo.Member;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	@GetMapping("review_Main.bo")
	public String reviewBoardList(@RequestParam(value="page", required=false) Integer currentPage, Model model) {
		
		if(currentPage == null) {
			currentPage = 1;
		}
		
		int listCount = bService.getListCount(1);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		
		ArrayList<Board> list = bService.reviewBoardList(pi, 1);
		
		
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			return "review_Main";
		} else {
			throw new BoardException("게시글 조회를 실패하였습니다.");
		}
	}
	
	@GetMapping("jibsa_List.bo")
	public String jibsaList(@RequestParam(value="page", required=false) Integer page,
							Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getJibsaListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		
		ArrayList<JibsaProfile> pList = bService.selectJibsaProfileList(pi);
				
		if(pList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("pList", pList);
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
		
		if(jibsa != null) {
			model.addAttribute("page", page);
			model.addAttribute("jibsa", jibsa);
			model.addAttribute("jp", jp);
			return "jibsa_Detail";
		} else {
			throw new BoardException("게시글 조회를 실패하였습니다.");
		}
	}

	
	@RequestMapping("search.bo")
	public String searchListCount(@RequestParam(value="page", required=false) Integer currentPage, HttpServletRequest request, Model model) {
		
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
	
	@GetMapping("review_Detail.bo")
	public String reviewDetail(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session, @RequestParam("bId") int bId, @RequestParam("writer") String writer, @RequestParam("jibsa") String jibsa) {
		
		
		if(page == null) {
			page = 1;
		}
		
		Member m = (Member)session.getAttribute("loginUser");
		String login = null;
		if(m != null) {
			login = m.getMemberId();
		}
		boolean yn = false;
		if(!writer.equals(login)) {
			yn = true;
		}
		
		Board b = bService.reviewDetail(bId, yn);	
		ArrayList<Board> list = bService.reviewDetailReply(jibsa);
			
		
		if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
			model.addAttribute("list", list);

			return "review_Detail";
		} else {
			throw new BoardException("게시글 상세보기를 실패하였습니다.");
		}
		
	}
}
	
