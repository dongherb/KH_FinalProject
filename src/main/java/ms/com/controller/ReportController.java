package ms.com.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.ReportDTO;
import ms.com.dto.ReviewDTO;
import ms.com.service.MemberService;
import ms.com.service.ReportService;
import ms.com.service.ReviewService;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Autowired
	private ReportService report_service;
	@Autowired
	private ReviewService review_service;
	@Autowired
	private MemberService member_service;
	
	@RequestMapping("/toReportList")
	public String toReportList(int currentPage, Model model) throws Exception{
		List<ReportDTO> list_report = report_service.selectAll(currentPage);
		List<ReviewDTO> list_review = review_service.selectAll();
		HashMap<String, Object> naviMap = report_service.getPageNavi(currentPage);
		
		model.addAttribute("list_report", list_report);
		model.addAttribute("list_review", list_review);
		model.addAttribute("naviMap", naviMap);
		return "report_manager/reportList";
	}
	
	@RequestMapping("/toSearchList")
	public String toSearchList(String category, String searchOption, String keyword, int currentPage, Model model) throws Exception{		
		List<ReportDTO> list_report = report_service.getSearchList(category, searchOption, keyword, currentPage);
		List<ReviewDTO> list_review = review_service.selectAll();
		HashMap<String, Object> naviMap = report_service.getPageNaviBySearch(category, searchOption, keyword, currentPage);
		
		model.addAttribute("list_report", list_report);
		model.addAttribute("list_review", list_review);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("category", category);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("keyword", keyword);
		return "report_manager/reportList";
	}
	
	@RequestMapping("/deleteReport.do")
	public String deleteReport(int report_seq, String id) throws Exception{
		report_service.deleteReport(report_seq);
		member_service.decReported_count(id);
		return "redirect:/report/toReportList?currentPage=1";
	}
	
	@RequestMapping("/deleteChecked.do")
	public String deleteProduct(String[] chk_Val) throws Exception{
		report_service.deleteChecked(chk_Val);
		return "redirect:/report/toReportList?currentPage=1";
	}
	
	@RequestMapping("toReportPopup")
	public String toReportPopup(Model model, int review_seq, String id) throws Exception{
		model.addAttribute("review_seq", review_seq);
		model.addAttribute("id", id);
		return "report_user/reportPopup";
	}
	
	@RequestMapping("/insertReport.do")
	public String insertReport(Model model, ReportDTO dto, String reportedId) throws Exception{
		int alreadyReport = report_service.alreadyReport(dto);
		
		if(alreadyReport >= 1) {
			model.addAttribute("done", "alreadyReport");	
		}else {
			int rs1 = report_service.insertReport(dto);
			if(rs1 == 1) {
				model.addAttribute("done", "done");
			}else {
				model.addAttribute("done", "fail");
			}
		}
		return "report_user/reportPopup";
	}
}
