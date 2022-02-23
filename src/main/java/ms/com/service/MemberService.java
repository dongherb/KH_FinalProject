package ms.com.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ms.com.dao.MemberDAO;
import ms.com.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO mDao;
	@Autowired
	private JavaMailSender mailSender;

	// 인증키 생성
	public String createKey() throws Exception {
		String key = "";
		Random rd = new Random();

		for (int i = 0; i < 8; i++) {
			key += rd.nextInt(10);
		}
		return key;
	}

	// 메일전송
	public void sendMail(String email, String key, String msg) throws Exception {
		String subject = ""; 
		String content = "";
		String from = "kht1122@gmail.com"; // 보내는이 아이디@도메인주소
		String to = email; // 받는이 아이디@도메인주소

		try {
			if(msg.equals("email")){
				subject = "MOOD & STYLE 회원가입 인증 이메일 입니다."; // 메일제목
				content = "MOOD & STYLE을 방문해주셔서 감사합니다." + "<br>" + "인증 번호는 " + key + "입니다." + "<br>"
						+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; // 메일내용
				
			}else if(msg.equals("tempPw")) {
				subject = "MOOD & STYLE 임시 비밀번호 입니다."; // 메일제목
				content = "MOOD & STYLE을 방문해주셔서 감사합니다." + "<br>" + "임시 비밀번호는 " + key + "입니다. " + "<br>"
						+ "로그인 후 반드시 비밀번호를 변경해주세요."; // 메일내용
			}
			
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);	
			mailSender.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	// 카카오 엑세스토큰 얻기
	   public String getAccessToken(String authorize_code) throws Exception {
	      String access_Token = "";
	      String refresh_Token = "";
	      String reqURL = "https://kauth.kakao.com/oauth/token";
	      try {
	         URL url = new URL(reqURL);
	         HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	         // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	         conn.setRequestMethod("POST");
	         conn.setDoOutput(true);

	         // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	         BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	         StringBuilder sb = new StringBuilder();
	         sb.append("grant_type=authorization_code"); // 인증코드
	         sb.append("&client_id=e43b1a5d4ceca562dba92ae1b279974d"); // client_id
	         sb.append("&redirect_uri=http://3.35.231.101/member/kakaoLogin.do"); // redirect_uri
	         sb.append("&code=" + authorize_code);
	         bw.write(sb.toString());
	         bw.flush();

	         int responseCode = conn.getResponseCode();
	         System.out.println("responseCode : " + responseCode);

	         // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	         BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	         String line = "";
	         String result = "";
	         while ((line = br.readLine()) != null) {
	            result += line;
	         }
	         System.out.println("response body : " + result);
	         JsonParser parser = new JsonParser();
	         JsonElement element = parser.parse(result);

	         access_Token = element.getAsJsonObject().get("access_token").getAsString();
	         refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	         System.out.println("access_token : " + access_Token); // 6시간용 토큰
	         System.out.println("refresh_token : " + refresh_Token); // 2달용 토큰
	         br.close();
	         bw.close();
	         conn.disconnect();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	      return access_Token;
	   }

	// 카카오 사용자 정보 가져오기
	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String id = "";
			String name = "";
			String email = "";
			id = element.getAsJsonObject().get("id").getAsString();
			name = properties.getAsJsonObject().get("nickname").getAsString();
			userInfo.put("id", "k@" + id); // k@+id로 카카오계정 구분
			userInfo.put("name", name);

			// 이메일 제공 허용했을때만
			if (kakao_account.has("email")) {
				email = kakao_account.getAsJsonObject().get("email").getAsString();
			}
			userInfo.put("email", email);

			br.close();
			conn.disconnect();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;

	}

	// 카카오 로그아웃
	public void kakaoLogout(String access_Token) throws Exception {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String result = "";
			String line = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("로그아웃" + result);
			br.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 카카오 연결해제 테스트
	public void kakaoWithdraw(String access_Token) throws Exception {
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String result = "";
			String line = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("카카오 연결해제" + result);
			br.close();
			conn.disconnect();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 아이디 중복확인
	public boolean checkId(String id) throws Exception {
		if (mDao.checkId(id) == 1) {
			return false;

		} else {
			return true;
		}

	}

	// 회원가입
	public int insertMember(MemberDTO dto) throws Exception {
		return mDao.insertMember(dto);
	}

	// 로그인
	public boolean isLoginOk(String id, String pw) throws Exception {

		if (mDao.isLoginOk(id, pw) == 1) {
			return true;
		} else {
			return false;
		}
	}

	// 아이디 찾기
	public String searchId(String email, String phone) throws Exception {
		return mDao.searchId(email, phone);

	}
	
	// 비밀번호 찾기(존재하는 회원인지 체크) 
	public boolean checkPw(String id, String email) throws Exception {
		if(mDao.checkPw(id, email)==1) {
			return true;
		}else {
			return false;
		}
	}

	// 멤버정보가져오기
	public MemberDTO getMember(String id) throws Exception {
		return mDao.getMember(id);
	}

	// 해당 사용자의 정보를 수정함
	public int update_member(MemberDTO dto) throws Exception {
		return mDao.update_member(dto);
	}
	
	// 해당 사용자의 포인트를 증가시킴 // 리뷰작성, 결제, 출석
	public int updatePoint_member(String id, int addPoint) throws Exception {
		return mDao.updatePoint_member(id, addPoint);
	}
	
	// 해당 사용자의 포인트를 감소시킴 
	public int descPoint_member(String id, int use_point) throws Exception{
		return mDao.descPoint_member(id,use_point);
	}
	
	// 해당 사용자를 삭제함
	public int delete_member(String id) throws Exception {
		return mDao.delete_member(id);
	}
	
	// 해당 사용자의 비밀번호를 수정함
	public int modifyPassword_member(String id, String pw) throws Exception {
		return mDao.modifyPassword_member(id, pw);
	}
	
	// 신고당한 아이디 신고횟수 증가
	public int addReported_count(String id) throws Exception {
		return mDao.addReported_count(id);
	}

	// 신고당했던 아이디 신고횟수 감소 (관리자가 신고 삭제 시)
	public int decReported_count(String id) throws Exception {
		return mDao.decReported_count(id);
	}
	
	//----------------------------------------------------------------
	// 관리자: 회원정보를 리스트로 불러오기
	private int recordCntPage = 10;
	private int naviCntPage = 5;

	private int[] getPageInfromations(int currentPage) throws Exception {

		int recordTototalCnt = mDao.getMemberCount(); // 해당 카테고리의 전체 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % recordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	// 검색시 사용될 메서드
	private int[] getSearchPageInfromations(String searchOption, String rank, String keyword, int currentPage)
			throws Exception {

		int recordTototalCnt = mDao.getMemberCountBySearch(searchOption, rank, keyword); // 검색한 전체
		// 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % recordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	public HashMap<String, Object> getPageNavi(int currentPage) throws Exception {

		currentPage = getPageInfromations(currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getPageInfromations(currentPage)[1]; // 총 페이지 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / naviCntPage) * naviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
			needNext = false;

		// 키 값 밸류값으로 담음
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);

		return map;
	}

	// 검색 시 사용 메서드
	public HashMap<String, Object> getPageNaviBySearch(String searchOption, String rank, String keyword,
			int currentPage) throws Exception {

		currentPage = getSearchPageInfromations(searchOption, rank, keyword, currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getSearchPageInfromations(searchOption, rank, keyword, currentPage)[1]; // 총 페이지
		// 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / naviCntPage) * naviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
			needNext = false;

		// 키 값 밸류값으로 담음
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);

		return map;
	}

	public List<MemberDTO> selectAll(int currentPage) throws Exception {
		int recordTototalCnt = mDao.getMemberCount(); // 해당 조건에 맞는 데이터의 수
		currentPage = getPageInfromations(currentPage)[0]; // 현재페이지로 일어난 오류를 방지

		// ----------------------------------------------------------------------------

		int startRange = ((currentPage - 1) * recordCntPage) + 1; // 보여지는 데이터 시작
		int endRange = currentPage * recordCntPage; // 보여지는 데이터 끝
		if (endRange >= recordTototalCnt) { // 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<MemberDTO> list = mDao.selectAll(startRange, endRange); // 범위에있는 값을 list로 가져옴
		return list;
	}

	// 검색시 불러올 신고 List
	public List<MemberDTO> getSearchList(String searchOption, String rank, String keyword, int currentPage)
			throws Exception {
		int recordTototalCnt = mDao.getMemberCountBySearch(searchOption, rank, keyword);
		currentPage = getSearchPageInfromations(searchOption, rank, keyword, currentPage)[0];

		int startRange = ((currentPage - 1) * recordCntPage) + 1;
		int endRange = currentPage * recordCntPage;
		if (endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}

		List<MemberDTO> list = mDao.selectMemberBySearch(searchOption, rank, keyword, startRange, endRange);
		return list;
	}

	// 회원 상태 수정하기
	public int changeState(String[] id, String[] state) throws Exception {
		return mDao.changeState(id, state);
	}

	// 체크된 회원 전체 활동으로 변경
	public int activeState(String[] id) throws Exception {
		return mDao.activeState(id);
	}

	// 체크된 회원 전체 정지로 변경
	public int banState(String[] id) throws Exception {
		return mDao.banState(id);
	}

}
