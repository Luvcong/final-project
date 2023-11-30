package com.kh.porong.notice.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kh.porong.common.controller.FileControllerBase;
import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.notice.model.service.NoticeService;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.notice.model.vo.NoticeAttachment;

@Controller
public class NoticeController extends FileControllerBase {
	
	@Autowired
	private NoticeService noticeService;
	
	
	/**
	 * 공지사항 리스트 전체 리스트 및 개수 조회
	 * @return 공지사항 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	@RequestMapping("noticeList")
	public String noticeList(@RequestParam(value="page", defaultValue="1") int currentPage, Model model) {
		
		int listCount = noticeService.noticeListCount();
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		
		model.addAttribute("list", noticeService.noticeList(pi));
		model.addAttribute("pi", pi);
		
		return "notice/noticeList";
	}	// noticeList
	
	
	/**
	 * 공지사항 작성 양식
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	@GetMapping("noticeWriteForm")
	public String noticeWriteForm() {
		return "notice/noticeWriteForm";
	}	// noticeWrite

	
	/**
	 * 공지사항 작성 (empAdmin == 'A' 인 사원만 작성 가능)
	 * @return 공지사항 작성 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	@PostMapping("insertNotice")
	public String insertNotice(@SessionAttribute(name= "loginUser", required= false) Employee loginUser,
							   @RequestParam("multiFile") MultipartFile[] multiFileList,
							   Notice n,
							   HttpServletRequest request) {
		
		// System.out.println("multiFileList : " + multiFileList);
		// System.out.println("fileContent : " + n);
		int empNo = loginUser.getEmpNo();
		n.setEmpNo(empNo);
		
		// 공지사항 작성에 성공한 경우에만 첨부파일 작성 코드 수행
		if((noticeService.insertNotice(n) == 0)) {
			request.getSession().setAttribute("failMsg", "공지사항 작성에 실패했습니다");
			return "redirect:noticeList";
		}
		
		if(multiFileList == null)
			return "redirect:noticeList";
			
		// 첨부파일 돌면서 > 원본파일명 확인 > 공백이 아닌 경우 > 첨부파일 insert
		for(MultipartFile file : multiFileList) {
			if(file.getOriginalFilename().equals(""))
				continue;
			
			NoticeAttachment attach = new NoticeAttachment();	// 첨부파일 객체 생성
			Path fullPath = Paths.get(saveFile(file, request.getSession(), "notice/"));	// 파일의 수정파일명 풀경로 구하기
			
			// System.out.println("getParent : " + fullPath.getParent());
			// System.out.println("getFileName : " + fullPath.getFileName());
			
			attach.setOriginFileName(file.getOriginalFilename());		// 원본파일명 전달
			attach.setChangeFileName(fullPath.getFileName().toString());	// 수정파일명 전달
			attach.setFilePath(fullPath.getParent().toString());			// 파일경로 전달
			
			noticeService.insertAttachment(attach);							// 첨부파일 추가	
				
			request.getSession().setAttribute("successMsg", "공지사항 작성에 성공했습니다!");
		}
		return "redirect:noticeList";
	}	// insertNotice
	
	
	/**
	 * 공지사항 게시글 상세보기
	 * @param nno : 상세보기 하려는 공지사항 게시글 번호
	 * @param loginUser : 로그인한 사용자의 정보
	 * @param model
	 * @return 게시글 번호에 해당하는 게시글 정보 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	@GetMapping("detailNotice")
	public String detailNotice(int nno,
							  @SessionAttribute(name="loginUser", required=false) Employee loginUser,
							  Model model) {
		
		// System.out.println("nno : " + nno);
		int empNo = loginUser.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("noticeNo", nno);
		
		
		if(noticeService.checkNoticeLike(map) > 0) {
			System.out.println("좋아요했당");
		} else {
			System.out.println("좋아요 안했당");
		}
		
		List<Notice> list = noticeService.detailNotice(map);
		List<NoticeAttachment> attachList = new ArrayList<NoticeAttachment>();
		System.out.println("list.get(0) : " + list.get(0));
		
		for(Notice notice : list) {
			NoticeAttachment at = new NoticeAttachment();
			at.setNoticeNo(notice.getNoticeNo());
			at.setOriginFileName(notice.getOriginFileName());
			at.setChangeFileName(notice.getChangeFileName());
			at.setFilePath(notice.getFilePath());
			
			attachList.add(at);
		}
		
		System.out.println("attachList:" + attachList);
		
		model.addAttribute("list", list.get(0));
		model.addAttribute("attachList", attachList);
		//model.addAttribute("list", noticeService.detailNotice(map));
		model.addAttribute("likeList", noticeService.checkNoticeLike(map));
		
		return "notice/detailNotice";
	}	// detailNotice
	
	
	
	

}	// end class
