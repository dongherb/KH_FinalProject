package ms.com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.CalendarInfoDTO;
import ms.com.dto.MemberDTO;
import ms.com.service.AttendService;
import ms.com.service.MemberService;

@Controller
@RequestMapping(value = "/mypageAttend")
public class MyPageAttendController {		// 김준형

	@Autowired
	private HttpSession session;
	@Autowired
	private AttendService service;
	@Autowired
	private MemberService service_member;

	// 출석체크 페이지로
	@RequestMapping(value = "/toCheckPage")
	public String toCheckPage(int selectMonth, String done, Model model) throws Exception {

		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String id = dto_mem.getId();
		
		CalendarInfoDTO dto_cal = service.getCalendarInfo(selectMonth);	// 해당 월을 기준으로 달력정보를 가져옴 / 해당 월, 해당 월의 첫 요일, 해당 월의 총 일수
		List<String> enteredDays = service.getEnteredDays_attend(id, selectMonth);	// 출석한 날짜를 list에 담음
		
		System.out.println(enteredDays);	// 확인용
		
		model.addAttribute("calendarInfo", dto_cal);
		model.addAttribute("selectMonth", selectMonth);
		model.addAttribute("enteredDays", enteredDays);
		if(done != null) {
			model.addAttribute("done", done);
		}
		
		return "/mypage/checkPage";
	}
	
	// 출석 시 데이터 저장
	@RequestMapping(value = "/enterCheckProc")
	public String enterCheckProc(Model model) throws Exception {

		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String id = dto_mem.getId();
		
		boolean exsitCheck = service.checkEnter_attend(id);
		if(!exsitCheck) {
			int rs = service.insert_attend(id);
			if(rs >= 1) {	// 성공
				model.addAttribute("done", "done");
				
				service_member.updatePoint_member(id, 10);	// 출석시 포인트 10 획득
				session.setAttribute("loginSession", (MemberDTO)(service_member.getMember(id)));	// 로그인세션 최신화(필수)
			}
			else {	// 실패
				model.addAttribute("done", "fail");
			}
		}
		else {	// 출석이미 존재
			model.addAttribute("done", "exsit");
		}

		return "redirect:/mypageAttend/toCheckPage?selectMonth=0";
	}
	
}
