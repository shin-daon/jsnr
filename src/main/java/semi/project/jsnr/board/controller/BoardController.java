package semi.project.jsnr.board.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import semi.project.jsnr.board.model.exception.BoardException;
import semi.project.jsnr.board.model.service.BoardService;
import semi.project.jsnr.board.model.vo.Board;
import semi.project.jsnr.common.Pagination;
import semi.project.jsnr.common.model.vo.PageInfo;
import semi.project.jsnr.jibsa.model.vo.Jibsa;
import semi.project.jsnr.jibsa.model.vo.JibsaProfile;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	
//	@GetMapping("reviewMain.bo")
//	public String selectBoardList(@RequestParam(value="page", required=false) Integer currentPage, Model model) {
//		if(currentPage == null) {
//			currentPage = 1;
//		}
//		
//		int listCount = bService.getListCount(1);
//		
//		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
//		
//		ArrayList<Board> list = bService.selectBoardList(pi, 1);
//		
//		if(list != null) {
//			model.addAttribute("pi", pi);
//			model.addAttribute("list", list);
//			return "review_Main";
//		} else {
//			throw new BoardException("게시글 조회를 실패하였습니다.");
//		}
//	}
	
	@GetMapping("reviewMain.bo")
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
}
