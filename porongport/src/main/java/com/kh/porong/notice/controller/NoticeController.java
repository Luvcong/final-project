package com.kh.porong.notice.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
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
	@RequestMapping("notice")
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
								@RequestParam("multiFile") List<MultipartFile> multiFileList,
								Notice n, HttpServletRequest request) {
		
		// System.out.println("multiFileList : " + multiFileList);
		// System.out.println("fileContent : " + n);
		int empNo = loginUser.getEmpNo();
		n.setEmpNo(empNo);
		
		if(noticeService.insertNotice(n) > 0){
			request.getSession().setAttribute("successMsg", "공지사항 작성에 성공했습니다!");
			for(MultipartFile mulFile : multiFileList) {
				NoticeAttachment attach = new NoticeAttachment();
				Path fullPath = Paths.get(saveFile(mulFile, request.getSession(), "notice"));
				
				attach.setOriginFileName(mulFile.getOriginalFilename());
				attach.setChangeFileName(fullPath.getFileName().toString());
				attach.setFilePath(fullPath.getParent().toString());
				attach.setNoticeNo(n.getNoticeNo());
				
				noticeService.insertAttachment(attach);
			}
		} else {
			request.getSession().setAttribute("failMsg", "공지사항 작성에 실패했습니다");
		}
		return "notice/noticeList";
		// return "notice/detailNotice?nno=" + notice_no;
	}
	
	
	
	public String detailNotice(int nno,
							  @SessionAttribute(name="loginUser", required=false) Employee loginUser,
							  Model model) {
		
		int empNo = loginUser.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("noticeNo", nno);
		
		model.addAttribute("list", noticeService.detailNotice(map));
		
		return "notice/detailNotice";
	}	// detailNotice
	
	
	
	

}	// end class
