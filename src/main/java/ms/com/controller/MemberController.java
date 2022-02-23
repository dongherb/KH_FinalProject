package ms.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ms.com.dto.MemberDTO;
import ms.com.dto.ProductDTO;
import ms.com.service.MemberService;
import ms.com.service.ProductService;
import ms.com.utils.EncryptionUtils;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private ProductService service_product;
	@Autowired
	private HttpSession session;

	// 로그인 페이지로
	@RequestMapping(value = "/toLoginPage")
	public String toLoginPage(Model model) throws Exception {

		List<ProductDTO> list = service_product.selectAll(); // 모든 리스트 불러오기

		if (!list.isEmpty()) { // 제품 리스트가 존재할 시

			int maxSize = list.size(); // 리스트 수

			Random random = new Random();
			model.addAttribute("product", list.get(random.nextInt(maxSize))); // 해당 리스트에서 랜덤으로 하나의 제품정보를 보냄
		}

		return "member/login";
	}

	// 카카오 로그인 + 회원가입
	@RequestMapping(value = "/kakaoLogin.do", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model)
			throws Exception {
		System.out.println("authorize_code" + code);
		String access_Token = service.getAccessToken(code); // code를 보내 access_Token 얻기
		HashMap<String, Object> userInfo = service.getUserInfo(access_Token); // access_Token을 보내 사용자 정보 얻기
		System.out.println("access_Token : " + access_Token);
		System.out.println("id : " + userInfo.get("id"));
		System.out.println("name : " + userInfo.get("name"));
		System.out.println("email : " + userInfo.get("email"));
		session.setAttribute("access_Token", access_Token);

		if (service.checkId((String) userInfo.get("id"))) { // id체크해서 없다면 카카오회원가입
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("msg", "done");
			return "member/kakaoSignup";
		} else { // id체크해서 존재하면 카카오로그인
			MemberDTO dto = service.getMember((String) userInfo.get("id"));
			session.setAttribute("loginSession", dto);
			return "redirect:/";
		}
	}

	// 회원가입 페이지로
	@RequestMapping("/toSignup.do")
	public String toSignup() {
		return "member/signup";
	}

	// 아이디 확인
	@RequestMapping("/checkId.do")
	@ResponseBody
	public String checkId(String id) throws Exception {
		if (service.checkId(id)) {
			return "available";
		} else {
			return "unavailable";
		}
	}

	// 이메일 인증
	@RequestMapping(value = "/checkEmail", method = RequestMethod.GET)
	@ResponseBody
	public String checkEmail(String email) throws Exception {
		String key = service.createKey(); // 인증키 생성
		service.sendMail(email, key, "email"); // 메일(인증키) 전송
		return key;
	}

	// 아이디 찾기
	@RequestMapping(value = "/searchId.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, String> searchId(String email, String phone) throws Exception {
		String id = service.searchId(email, phone);
		HashMap<String, String> map = new HashMap<String, String>();
		if (id == null) {
			map.put("msg", "fail");
		} else {
			map.put("msg", "success");
			map.put("id", id);
		}

		return map;
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/searchPw.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, String> searchPw(String id, String email) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();

		if (service.checkPw(id, email)) { // 회원의 id email 가 일치하면
			String pw = service.createKey(); // 임시비밀번호 생성
			if (service.modifyPassword_member(id, EncryptionUtils.getSHA512(pw)) == 1) { // 암호화한 임시비밀번호로 변경되면
				service.sendMail(email, pw, "tempPw"); // 메일(임시비밀번호) 전송
				map.put("msg", "success");
				map.put("email", email);
			} else {
				map.put("msg", "fail");
			}
		} else {
			map.put("msg", "fail");
		}
		return map;
	}

	// 회원가입 요청
	@RequestMapping("/signup.do")
	public String signup(MemberDTO dto) throws Exception {
		if (dto.getPw() != "") { // 일반회원가입
			dto.setPw(EncryptionUtils.getSHA512(dto.getPw()));
			service.insertMember(dto);

			return "redirect:/member/toLoginPage";
		} else { // 카카오회원가입
			service.insertMember(dto);
			session.setAttribute("loginSession", dto);
			return "redirect:/";
		}

	}

	// 일반 로그인
	@RequestMapping(value = "/login.do", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String login(String id, String pw) throws Exception {

		if (service.isLoginOk(id, EncryptionUtils.getSHA512(pw))) {
			MemberDTO dto = service.getMember(id);
			if (dto.getState().equals("활동")) {
				session.setAttribute("loginSession", dto);
				return "성공";
			} else {
				return "정지";
			}
		} else {
			return "실패";
		}
	}

	// 로그아웃
	@RequestMapping("/toLogout.do")
	public String logout() throws Exception {
		if ((String) session.getAttribute("access_Token") == null) {
			// 일반 로그아운
			session.invalidate();
			System.out.println("일반로그아웃");
		} else {
			// 카카오 로그아웃
			service.kakaoLogout((String) session.getAttribute("access_Token"));
			session.invalidate();
			session.removeAttribute("loginSession");
			session.removeAttribute("access_Token");
			System.out.println("카카오로그아웃");
		}
		return "redirect:/";
	}

	// ----------------------------------------------------------------------
	// 회원리스트 불러오기 // 관리자전용
	@RequestMapping("/toMemberList")
	public String toMemberList(int currentPage, Model model) throws Exception {
		List<MemberDTO> list = service.selectAll(currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(currentPage);

		model.addAttribute("list", list);
		model.addAttribute("naviMap", naviMap);
		return "member_manager/memberList";
	}

	// 회원 검색 목록 불러오기
	@RequestMapping("/toSearchList")
	public String toSearchList(String searchOption, String rank, String keyword, int currentPage, Model model)
			throws Exception {
		List<MemberDTO> list = service.getSearchList(searchOption, rank, keyword, currentPage);
		HashMap<String, Object> naviMap = service.getPageNaviBySearch(searchOption, rank, keyword, currentPage);

		model.addAttribute("list", list);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("keyword", keyword);
		return "member_manager/memberList";
	}

	// 회원 상태 변경
	@RequestMapping("/changeState.do")
	public String changedState(String[] id, String[] state) throws Exception {
		service.changeState(id, state);
		return "redirect:/member/toMemberList?currentPage=1";
	}

	// 체크 목록 전체 활동으로 변경
	@RequestMapping("/activeState.do")
	public String activeState(String[] id) throws Exception {
		service.activeState(id);
		return "redirect:/member/toMemberList?currentPage=1";
	}

	// 체크 목록 전체 활동으로 변경
	@RequestMapping("/banState.do")
	public String banState(String[] id) throws Exception {
		service.banState(id);
		return "redirect:/member/toMemberList?currentPage=1";
	}
}
