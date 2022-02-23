package ms.com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ms.com.dto.EnquiryDTO;
import ms.com.dto.MemberDTO;
import ms.com.service.EnquiryService;

@RequestMapping("/enquiry")
@Controller
public class EnquiryController {
	@Autowired
	private EnquiryService service;
	@Autowired
	private HttpSession session;
	
	//문의하기 페이지 요청
	@RequestMapping("/toEnquiryList")
	public String toEnquiry(Model model)throws Exception {
		//1. 컨트롤러에서 회원 or 관리자 구분 후 진행 manager_yn 구분 후 진행
		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String member_id = dto_mem.getId();
//		HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
//		ArrayList<EnquiryDTO> list = service.getBoardList((int)naviMap.get("currentPage"));	    
        List<EnquiryDTO> list = service.selectMyRegister(member_id);
		model.addAttribute("list", list);
			return "mypage/enquiry_user/enquiryList";
		 }
	
	//문의글 쓰기 페이지 요청
	@RequestMapping("/toInsertEnquiry")
	public String toInsertEnquiry() {
		return "mypage/enquiry_user/enquiryWrite";
	}
	
	//문의글 작성완료 후 리스트 돌아가기
	@RequestMapping("/insertEnquiry.bo")
	public String write(EnquiryDTO dto) throws Exception{	
		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
        String id = dto_mem.getId();
        dto.setId(id);
        service.insertEnquiry(dto);
		return "redirect:/enquiry/toEnquiryList";
	}
	
	//문의글 상세보기
	@RequestMapping("/toDetail")
	public String toDetail(int enquiry_seq, Model model) throws Exception{
		EnquiryDTO dto = service.selectOne(enquiry_seq);
		model.addAttribute("dto", dto);	
		return "mypage/enquiry_user/enquiryDetail";
	}
	
	//문의글 수정 페이지 이동
	@RequestMapping("/toModifyEnquiry")
	public String toModifyEnquiry(int enquiry_seq, Model model) throws Exception{
		EnquiryDTO dto = service.selectOne(enquiry_seq);
		model.addAttribute("dto",dto);
		return "mypage/enquiry_user/enquiryModify";
	}
	
	//문의글 수정
	@RequestMapping("/modifyEnquiry.bo")
	public String modifyEnquiry(EnquiryDTO dto) throws Exception{
		service.modifyEnquiry(dto);
		return "redirect:/enquiry/toEnquiryList";
	}
	
	//문의글 삭제하기
	@RequestMapping("/deleteEnquiry.bo")
	public String deleteEnquiry(int enquiry_seq) throws Exception{
		service.deleteEnquiry(enquiry_seq);
		return "redirect:/enquiry/toEnquiryList";
	}
		
	//관리자 전체문의글 리스트 페이지 요청
	@RequestMapping("/toMangerEnquiryList")
	public String toMangerEnquiryList(Model model)throws Exception {
		List<EnquiryDTO> list = service.selectAll();
		model.addAttribute("list", list);
		return "enquiry_manager/manager_EnquiryList";
	}
		
	//관리자 문의사항 상세 페이지 요청
	@RequestMapping("/toEnquiryDetail")
	public String toEnquiryDetail(int enquiry_seq, Model model) throws Exception{
		EnquiryDTO dto= service.selectOne(enquiry_seq);
		model.addAttribute("dto", dto);		
		return "enquiry_manager/manager_EnquiryDetail";
	}
	
	//관리자 문의사항 댓글 등록
	@RequestMapping(value="/insertComment.co", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String updateEnquiryComment(EnquiryDTO dto) throws Exception {
		if(service.updateEnquiryComment(dto) == 1) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	//관리자 문의사항 댓글 띄우기
	@RequestMapping(value="/getComment.co", produces="application/json;charset=UTF-8")
	@ResponseBody
	public EnquiryDTO getEnquiryComment(int enquiry_seq) throws Exception {
		EnquiryDTO dto = service.getEnquiryComment(enquiry_seq);
		return dto;
	}
	
	//관리자 문의사항 댓글 삭제
	@RequestMapping(value="/deleteEnquiryCmt.co")
	public String deleteEnquiryCmt(int enquiry_seq) throws Exception {
		if(service.deleteEnquiryCmt(enquiry_seq) == 1) {
			return "redirect:/enquiry/toEnquiryDetail?enquiry_seq=" + enquiry_seq;
		}else {
			return "fail";
		}
	}
	
	//관리자 문의사항 댓글 수정
	@RequestMapping(value="/enquiryModifyCmt.co")
	public String enquiryModifyCmt(EnquiryDTO dto) throws Exception {
		if(service.enquiryModifyCmt(dto) == 1) {
			System.out.println("댓글수정 DTO : "+ dto);
			return "redirect:/enquiry/toEnquiryDetail";
		}else {
			return "fail";
		}
	}

}
