package ms.com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.MemberDTO;
import ms.com.service.MemberService;
import ms.com.utils.EncryptionUtils;

@Controller
@RequestMapping(value = "/mypageHome")
public class MyPageHomeController {		// 김준형

	@Autowired
	private HttpSession session;
	@Autowired
	private MemberService service;
	
	
	// 회원정보 페이지로
	@RequestMapping(value = "/toMypageHome")
	public String toMypageHome() throws Exception{
		
		String id = ((MemberDTO)session.getAttribute("loginSession")).getId();
		session.setAttribute("loginSession", service.getMember(id));
		
		return "/mypage/mypageHome";
	}
	
	// 회원정보 수정 페이지로
	@RequestMapping(value = "/toMypageModify")
	public String toMypageModify() throws Exception{
		return "/mypage/mypageModify";
	}
	
	// 회원비밀번호 확인
	@RequestMapping(value = "/passwordCheckProc")
	public String passwordCheckProc(String pw, String type, Model model) throws Exception {
		
		MemberDTO dto_mem = (MemberDTO)(session.getAttribute("loginSession"));
		String id = dto_mem.getId();
		pw = EncryptionUtils.getSHA512(pw);	// 암호화필요
		
		boolean checkPw = service.isLoginOk(id, pw);	// 해당사용자의 비밀번호가 일치한지 확인
		
		if(checkPw == true) {	// 일치시
			if(type.equals("modifyPw")) {	// 비밀번호 변경 옵션
				model.addAttribute("checkPw", "toModifyPw");
			}
			else if(type.equals("withdraw")) {	// 회원탈퇴 옵션
				model.addAttribute("checkPw", "toWithdraw");
			}
		}
		else {	// 불일치 시
			model.addAttribute("checkPw", "wrong");
		}

		return "/mypage/mypageHome";
	}
	
	// 회원정보 수정
	@RequestMapping(value = "/modifyProc")
	public String modifyProc(MemberDTO dto, Model model) throws Exception {
		
		MemberDTO dto_mem = (MemberDTO)(session.getAttribute("loginSession"));
		dto.setId(dto_mem.getId());
		
		int rs = service.update_member(dto);
		if(rs == 1) {
			dto_mem = service.getMember(dto_mem.getId());
			session.setAttribute("loginSession", dto_mem);	// 수정된 회원정보를 세션에 담기
		}
		else {
			System.out.println("수정실패");
		}

		return "/mypage/mypageHome";
	}
	
	// 회원 탈퇴
    @RequestMapping(value = "/withdrawProc")
    public String withdrawProc() throws Exception {

        MemberDTO dto_mem = (MemberDTO) (session.getAttribute("loginSession"));
        String id = dto_mem.getId();

        int rs = service.delete_member(id);
        if (rs == 1) {
            // 카카오 회원 탈퇴 추가했습니다 // 김희태 
            if ((String) session.getAttribute("access_Token") != null) {
                service.kakaoWithdraw((String) session.getAttribute("access_Token"));
                session.removeAttribute("loginSession");
                session.removeAttribute("access_Token");

            } else {
                session.removeAttribute("loginSession");
            }

            System.out.println(id + "님이 회원을 탈퇴했습니다.");

        } else {
            System.out.println(id + "님이 회원탈퇴를 실패했습니다.");
        }
        return "/home";
    }
	
	// 비밀번호 수정페이지로 / 팝업
	@RequestMapping(value = "/toModifyPassword")
	public String toModifyPassword(String done, Model model) throws Exception {
		model.addAttribute("done", done);
		return "/mypage/modifyPassword";
	}
	
	// 비밀번호 수정
	@RequestMapping(value = "/modifyPasswordProc")
	public String modifyPasswordProc(String pw, Model model) throws Exception {
		
		pw = EncryptionUtils.getSHA512(pw);	// 암호화필요
		MemberDTO dto_mem = (MemberDTO)(session.getAttribute("loginSession"));
		
		if(pw.equals(dto_mem.getPw())) {	// 현재입력한 비밀번호와 기존의 비밀번호가 같을경우
			model.addAttribute("done", "duplication");	// 같은 비밀번호라고 알림
		}
		else {
			
			int rs = service.modifyPassword_member(dto_mem.getId(), pw);
			if(rs == 1) {	// 변경성공
				model.addAttribute("done", "done");
				
				dto_mem = service.getMember(dto_mem.getId());
				session.setAttribute("loginSession", dto_mem);	// 수정된 값을 세션에 담기
			}
			else {		// 변경실패
				model.addAttribute("done", "fail");
			}
		}
		return "redirect:/mypageHome/toModifyPassword";
	}
	
}
