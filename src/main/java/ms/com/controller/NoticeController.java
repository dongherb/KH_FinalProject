package ms.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dto.NoticeDTO;
import ms.com.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeService service;
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/toNoticeList")
	public String toNoticeList(int currentPage, Model model) throws Exception{
		List<NoticeDTO> list = service.selectAll(currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
		
		model.addAttribute("list", list);
		model.addAttribute("naviMap", naviMap);
		return "notice_manager/noticeList";
	}
	
	@RequestMapping("/toNoticeList_user")
	public String toNoticeList_user(int currentPage, Model model) throws Exception{
		List<NoticeDTO> list = service.selectAll(currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
		
		model.addAttribute("list", list);
		model.addAttribute("naviMap", naviMap);
		return "notice_user/noticeList";
	}
	
	@RequestMapping("/toSearchList")
	public String toSearchList(String keyword, int currentPage, Model model) throws Exception{
		System.out.println(keyword);
		List<NoticeDTO> list = service.getSearchList(keyword, currentPage);
		HashMap<String, Object> naviMap = service.getPageNaviBySearch(keyword, currentPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("keyword", keyword);
		return "notice_manager/noticeList";
	}
	
	@RequestMapping("/toSearchList_user")
	public String toSearchList_user(String keyword, int currentPage, Model model) throws Exception{
		System.out.println(keyword);
		List<NoticeDTO> list = service.getSearchList(keyword, currentPage);
		HashMap<String, Object> naviMap = service.getPageNaviBySearch(keyword, currentPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("keyword", keyword);
		return "notice_user/noticeList";
	}
	
	@RequestMapping("/toDetail")
	public String toDetail(int notice_seq, Model model) throws Exception{
		Map<String, Object> map = service.selectOne(notice_seq);
		model.addAttribute("dto", map.get("dto"));
		return "notice_manager/detailNotice";
	}
	
	@RequestMapping("/toDetail_user")
	public String toDetail_user(int notice_seq, Model model) throws Exception{
		Map<String, Object> map = service.selectOne(notice_seq);
		model.addAttribute("dto", map.get("dto"));
		return "notice_user/detailNotice";
	}
	
	@RequestMapping("/toInsertNotice")
	public String toInsertNotice() {
		return "notice_manager/insertNotice";
	}
	
	@RequestMapping("/insertNotice.do")
	public String insertNotice(NoticeDTO dto, MultipartFile[] file) throws Exception{
		String realPath = session.getServletContext().getRealPath("notice_img");
		service.insertNotice(dto, realPath, file);
		return "redirect:/notice/toNoticeList?currentPage=1";
	}
	
	@RequestMapping("/toModifyNotice")
	public String toModifyNotice(int notice_seq, Model model) throws Exception{
		Map<String, Object> map = service.selectOne(notice_seq);
		model.addAttribute("dto", map.get("dto"));
		return "notice_manager/modifyNotice";
	}
	
	@RequestMapping("/modifyNotice.do")
	public String modifyNotice(NoticeDTO dto, MultipartFile[] file) throws Exception{
		String realPath = session.getServletContext().getRealPath("notice_img");
		service.modifyNotice(dto, realPath, file);
		return "redirect:/notice/toNoticeList?currentPage=1";
	}
	
	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(int notice_seq) throws Exception{
		service.deleteNotice(notice_seq);
		return "redirect:/notice/toNoticeList?currentPage=1";
	}
	
	@RequestMapping("/deleteChecked.do")
	public String deleteProduct(String[] chk_Val) throws Exception{
		service.deleteChecked(chk_Val);
		return "redirect:/notice/toNoticeList?currentPage=1";
	}
}
