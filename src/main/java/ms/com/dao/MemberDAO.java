package ms.com.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession session;
	
	//아이디중복확인
	public int checkId(String id) throws Exception {
		return session.selectOne("memberMapper.checkId", id);
	}
	
	//회원가입
	public int insertMember(MemberDTO dto) throws Exception {
		return session.insert("memberMapper.insertMember", dto);
	}
	
	//로그인
	public int isLoginOk(String id, String pw) throws Exception{
		Map<String,String> map = new HashMap<>();
		map.put("id",id);
		map.put("pw",pw);
		return session.selectOne("memberMapper.isLoginOk",map);

	}
	
	//아이디 찾기
	public String searchId(String email, String phone) throws Exception{
		Map<String,String> map = new HashMap<>();
		map.put("email",email);
		map.put("phone",phone);
		return session.selectOne("memberMapper.searchId",map);
	}
	
	//비밀번호 찾기(존재하는 회원인지 체크) 
	public int checkPw(String id, String email) throws Exception{
		Map<String,String> map = new HashMap<>();
		map.put("id",id);
		map.put("email",email);
		return session.selectOne("memberMapper.checkPw",map);
	}
	
	//멤버정보 가져오기
	public MemberDTO getMember(String id) throws Exception{
		return session.selectOne("memberMapper.getMember", id);
	}
	
	// 현재 사용자의 정보를 수정함
	public int update_member(MemberDTO dto) throws Exception {
		return session.update("memberMapper.update_member", dto);
	}
	
	// 해당 사용자의 포인트를 증가시킴	// 리뷰작성, 결제, 출석때 작동됨
	public int updatePoint_member(String id, int addPoint) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("addPoint", addPoint);
		
		return session.update("memberMapper.updatePoint_member", map);
	}
	
	// 해당 사용자의 포인트를 감소시킴 
	public int descPoint_member(String id, int use_point) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("id",id);
		map.put("use_point", use_point);
		
		return session.update("memberMapper.descPoint_member",map); 
	}
	
	// 해당 사용자를 삭제함
	public int delete_member(String id) throws Exception {
		return session.delete("memberMapper.delete_member", id);
	}
	
	// 해당 사용자의 비밀번호를 수정함
	public int modifyPassword_member(String id, String pw) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		
		return session.update("memberMapper.modifyPassword_member", map);
	}
	
	// 신고당한 아이디 신고횟수 증가
	public int addReported_count(String id) throws Exception {
		return session.update("memberMapper.addReported_count", id);
	}

	// 신고당했던 아이디 신고횟수 감소 (관리자가 신고 삭제 시)
	public int decReported_count(String id) throws Exception {
		return session.update("memberMapper.decReported_count", id);
	}

	//---------------------------------------------------------------------
	// 관리자: 회원정보를 리스트로 불러오기
	public List<MemberDTO> selectAll(int startRange, int endRange) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("memberMapper.selectAll", map);
	}

	public int getMemberCount() throws Exception{
		return session.selectOne("memberMapper.getMemberCount");
	}
	
	// 검색한 범위 안의 데이터 리스트 반환
	public List<MemberDTO> selectMemberBySearch(String searchOption, String rank, String keyword, int startRange,
			int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		if (rank.equals("브론즈")) {
			map.put("rank", "브론즈");
		} else if (rank.equals("실버")) {
			map.put("rank", "실버");
		} else if (rank.equals("골드")) {
			map.put("rank", "골드");
		} else if (rank.equals("플래티넘")) {
			map.put("rank", "플래티넘");
		} else if (rank.equals("다이아몬드")) {
			map.put("rank", "다이아몬드");
		} else if (rank.equals("All")) {
			map.put("rank", "All");
		}

		return session.selectList("memberMapper.selectMemberBySearch", map);
	}

	// 검색한 회원들 총 데이터 수 반환
	public int getMemberCountBySearch(String searchOption, String rank, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		;

		if (rank.equals("브론즈")) {
			map.put("rank", "브론즈");
		} else if (rank.equals("실버")) {
			map.put("rank", "실버");
		} else if (rank.equals("골드")) {
			map.put("rank", "골드");
		} else if (rank.equals("플래티넘")) {
			map.put("rank", "플래티넘");
		} else if (rank.equals("다이아몬드")) {
			map.put("rank", "다이아몬드");
		} else if (rank.equals("All")) {
			map.put("rank", "All");
		}

		return session.selectOne("memberMapper.getMemberCountBySearch", map);
	}
	
	
	// 회원 상태 변경
	public int changeState(String[] id, String[] state) throws Exception{
		Map<String, Object> map = new HashMap<>();
		
		for(int i = 0; i<id.length; i++) {
			map.put("id", id[i]);
			map.put("state", state[i]);
			session.update("memberMapper.changeState", map);
		}
		return 1;
	}

	// 체크된 회원들 활동으로 변경
	public int activeState(String[] id) throws Exception {
		Map<String, Object> map = new HashMap<>();

		for (int i = 0; i < id.length; i++) {
			map.put("id", id[i]);
			map.put("state", "활동");
			session.update("memberMapper.changeState", map);
		}
		return 1;
	}

	// 체크된 회원들 정지로 변경
	public int banState(String[] id) throws Exception {
		Map<String, Object> map = new HashMap<>();

		for (int i = 0; i < id.length; i++) {
			map.put("id", id[i]);
			map.put("state", "정지");
			session.update("memberMapper.changeState", map);
		}
		return 1;
	}
}
