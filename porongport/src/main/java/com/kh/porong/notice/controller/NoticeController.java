package com.kh.porong.notice.controller;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.container.Suspended;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kh.porong.common.controller.IFileHandler;
import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.notice.model.service.NoticeService;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.notice.model.vo.NoticeAttachment;
import com.kh.porong.notice.model.vo.NoticeLike;

@Controller
public class NoticeController implements IFileHandler {
	
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
	 * 공지사항 게시글 검색 리스트 및 검색 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/부서/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
	 * @author JH
	 * @Date : 2023. 12. 2
	 */
	@RequestMapping("searchNoticeList")
	public String searchNoticeList(@RequestParam(value="page", defaultValue="1") int currentPage,
										String condition,
										String keyword,
										@SessionAttribute(name = "loginUser", required = false) Employee loginUser,
										Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("noticeWriter", loginUser.getEmpNo());
		
		PageInfo pi = Pagination.getPageInfo(noticeService.searchNoticeCount(map), currentPage, 10, 10);
		model.addAttribute("list", noticeService.searchNoticeList(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "notice/noticeList";
	}	// searchNoticeList
	
	
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
		n.setNoticeWriter(empNo);
		
		// 공지사항 작성에 성공한 경우에만 첨부파일 작성 코드 수행
		if((noticeService.insertNotice(n) == 0)) {
			request.getSession().setAttribute("failMsg", "공지사항 작성에 실패했습니다");
			return "redirect:noticeList";
		}
		
		// null 체크 - 첨부파일이 없는 경우 아래 코드 진행x
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
			
			attach.setOriginFileName(file.getOriginalFilename());			// 원본파일명 전달
			attach.setChangeFileName(fullPath.getFileName().toString());	// 수정파일명 전달
			attach.setFilePath(fullPath.getParent().toString());			// 파일경로 전달
			
			System.out.println(attach);
			noticeService.insertAttachment(attach);							// 첨부파일 추가
				
		}

		request.getSession().setAttribute("successMsg", "공지사항 작성에 성공했습니다!");
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
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("noticeWriter", empNo);
		map.put("noticeNo", nno);
		map.put("empNo", empNo);
		
//		if(noticeService.checkNoticeLike(map) > 0) {
//			System.out.println("좋아요했당");
//		} else {
//			System.out.println("좋아요 안했당");
//		}
		
		// 조회수 증가가 성공할 때만 detail 보여주기
		if(noticeService.increaseCount(nno) == 0){
			model.addAttribute("failMsg", "다시 시도해주세요");
			return "notice/detailNotice";
		}
		
		List<Notice> list = noticeService.detailNotice(map);
		List<NoticeAttachment> attachList = noticeService.selectAttachment(nno);
		// List<NoticeAttachment> attachList = new ArrayList<NoticeAttachment>();
		
		// System.out.println("list.get(0) : " + list.get(0));
		
//		for(Notice notice : list) {
//			NoticeAttachment at = new NoticeAttachment();
//			at.setNoticeNo(notice.getNoticeNo());
//			at.setOriginFileName(notice.getOriginFileName());
//			at.setChangeFileName(notice.getChangeFileName());
//			at.setFilePath(notice.getFilePath());
//			
//			attachList.add(at);
//		}
		
		// System.out.println("attachList:" + attachList);
		// int likeList = noticeService.checkNoticeLike(map);
		// System.out.println(likeList);
		
		model.addAttribute("list", list.get(0));
		model.addAttribute("attachList", attachList);
		model.addAttribute("likeList", noticeService.checkNoticeLike(map));
		
		return "notice/detailNotice";
	}	// detailNotice
	
	
	/**
	 * 공지사항 게시글 삭제
	 * @param nno : 삭제하려는 공지사항 번호 (noticeNo)
	 * @param changeFileName : 삭제 공지사항 번호에 첨부되어 있는 첨부파일명
	 * @param session
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @return 공지사항 게시글 삭제 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	@PostMapping("deleteNotice")
	public String deleteNotice(int nno,
							   String changeFileName[],
							   // MultipartFile[] multiFileList,
							   HttpSession session,
							   @SessionAttribute(name="loginUser", required=false) Employee loginUser) {
		
		int empNo = loginUser.getEmpNo();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("noticeWriter", empNo);
		map.put("noticeNo", nno);

		// 공지사항 삭제 성공시에만 첨부파일 삭제 > 첨부파일명이 공백이 아닌 경우 첨부파일 삭제 진행
		if(noticeService.deleteNotice(map) == 0) {
			session.setAttribute("failMsg", "공지사항 삭제 실패! 다시 시도해주세요");
			return "notice/noticeList";
		}
		
		// null 체크 - 첨부파일이 없는 경우 게시글 삭제만 진행하고 첨부파일 삭제 진행은 x
		if(changeFileName == null)
			return "redirect:noticeList";
			
		// changeFileName은 서버에 저장된 데이터 삭제하기 위해 필요! DB까지 들고 갈 필요 없음
		// 첨부파일 돌면서 > 원본파일명 확인 공백 아닌 경우 첨부파일 삭제 진행
		for(String file : changeFileName) {
			
			// 첨부파일 공백인경우 continue 
			if(file.equals(""))
				continue;
			
			// 첨부파일명이 공백이 아닌 경우 아래 코드 수행
			// System.out.println("changeFileName : " + file);
//			System.out.println("삭제경로확인1 : " + new File(session.getServletContext().getRealPath(filePath + "/" + file)));
//			new File(session.getServletContext().getRealPath(filePath + "/" + file)).delete();
			// System.out.println("삭제경로확인1 : " + new File(session.getServletContext().getRealPath(file)));
			new File(session.getServletContext().getRealPath(file)).delete();
		}
			
		noticeService.deleteNoticeAttach(map);
		
		session.setAttribute("successMsg", "공지사항 삭제 성공!");
		return "redirect:noticeList";
	}	// deleteNotice
	
	
	/** 
	 * 공지사항 게시글 수정 양식
	 * @return
	 * @author JH
	 * @Date : 2023. 12. 1
	 */
	@PostMapping("updateNoticeForm")
	public String updateNotice(int nno,
							   @SessionAttribute(name="loginUser", required=false) Employee loginUser,
							   Model model) {
		
		int empNo = loginUser.getEmpNo();
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("noticeWriter", empNo);
		map.put("noticeNo", nno);
		
		List<Notice> list = noticeService.detailNotice(map);
		List<NoticeAttachment> attachList = noticeService.selectAttachment(nno);
		
//		for(Notice notice : list) {
//			NoticeAttachment at = new NoticeAttachment();
//			at.setNoticeNo(notice.getNoticeNo());
//			at.setOriginFileName(notice.getOriginFileName());
//			at.setChangeFileName(notice.getChangeFileName());
//			at.setFilePath(notice.getFilePath());
//			
//			attachList.add(at);
//		}
		
		model.addAttribute("list", list.get(0));
		model.addAttribute("attachList", attachList);
		// System.out.println(list.get(0));
		// System.out.println(attachList);
		
		return "notice/updateNoticeForm";
	}	// updateNotice
	
	
	
	/**
	 * 공지사항 게시글 수정
	 * @param n : 공지사항 게시글 정보가 담겨있는 Notice VO 객체
	 * @param changeFileName : 수정 공지사항 번호에 첨부되어 있는 첨부파일명
	 * @param multiFileList : 수정시 새롭게 첨부한 파일 리스트
	 * @param loginUser : 현재 로그인한 사용자의 정보
	 * @param session
	 * @return 공지사항 게시글 수정 성공 여부 및 수정 내용 반환
	 * @author JH
	 * @Date : 2023. 12. 1
	 */
	@PostMapping("updateNotice")
	public String updateNotice(Notice n,
							   String changeFileName[],
			 				   @RequestParam("reUpMultiFile") MultipartFile[] multiFileList,
							   @SessionAttribute(name="loginUser", required=false) Employee loginUser,
							   HttpServletRequest request) {
		
		n.setNoticeWriter(loginUser.getEmpNo());
		System.out.println("Notice : " + n);
		
		// 공지사항 수정에 성공한 경우에만 첨부파일 작성 코드 수행
		if((noticeService.updateNotice(n) == 0)) {
			request.getSession().setAttribute("failMsg", "공지사항 수정에 실패했습니다");
			return "redirect:detailNotice?nno=" + n.getNoticeNo();
		}
		
		// null 체크 - 첨부파일이 없는 경우 게시글 수정만 진행하고 첨부파일 수정 진행은 x
		if(multiFileList.length == 1 && multiFileList[0].getSize() == 0) {
			request.getSession().setAttribute("successMsg", "공지사항 작성에 성공했습니다!");
			return "redirect:detailNotice?nno=" + n.getNoticeNo();
		}
			
		// 첨부파일 돌면서 > 새로운 파일명 확인 > 공백이 아닌 경우 > 첨부파일 insert + resources에 저장된 기존 파일 삭제
		for(MultipartFile newFile : multiFileList) {
			if(newFile.getOriginalFilename().equals(""))	// 파일 첨부 안하는 경우 / 로 넘어옴
				continue;
			
			for(String file : changeFileName) {
				// 첨부파일 공백인경우 continue 
				if(file.equals("/"))
					continue;
				// 공백이 아닌 경우 경로에서 찾아서 삭제
				new File(request.getSession().getServletContext().getRealPath(file)).delete();
			}
			
			java.util.Arrays.toString(multiFileList[0].getOriginalFilename().toCharArray());
			// 1) 파일이 기존에 있던 말던 현재 파일 삭제 기능이 없기 때문에
			// multiFileList에 파일이 있는 경우 무조건 isnert 처리 진행
			Path fullPath = Paths.get(saveFile(newFile, request.getSession(), "notice/"));	// 파일의 수정파일명 풀경로 구하기
			// List<NoticeAttachment> attachList = noticeService.selectAttachment(n.getNoticeNo());
			
			// -- 추가사항 : 시퀀스번호 / 원본파일명 / 수정파일명 / 파일경로 / 공지사항번호
			NoticeAttachment attach = new NoticeAttachment();
			attach.setOriginFileName(newFile.getOriginalFilename());
			attach.setChangeFileName(fullPath.getFileName().toString());
			attach.setFilePath(fullPath.getParent().toString());
			attach.setNoticeNo(n.getNoticeNo());
			
//			System.out.println("수정getParent : " + fullPath.getParent());
//			System.out.println("수정getFileName : " + fullPath.getFileName());
//			System.out.println("attach객체 나오나? : " + attach);
			
			// 추가정보를 담은 attach 객체 넘기면서 파일 insert
			// noticeService.insertAttachment(attach);
			
			noticeService.insertAttachment(attach);
			
		}
				
			request.getSession().setAttribute("successMsg", "공지사항 작성에 성공했습니다!");
			return "redirect:detailNotice?nno=" + n.getNoticeNo();
	}	// updateNotice
	
	
	
	
	

}	// end class
