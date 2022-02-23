package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.CalendarInfoDTO;

@Repository
public class AttendDAO {	// 김준형

	@Autowired
	private SqlSession session;

	// 현재 월을 기반으로 필요한 캘린더 정보 가져오기
	public CalendarInfoDTO getCalendarInfo(int selectMonth) throws Exception {
		return session.selectOne("attendMapper.getCalendarInfo", selectMonth);
	}

	// 현재날짜에 출석이 존재하는지 확인	// 존재 시 true / 없을 시 false
	public boolean checkEnter_attend(String id) throws Exception {
		return session.selectOne("attendMapper.checkEnter_attend", id);
	}

	// 해당 아이디 출석저장
	public int insert_attend(String id) throws Exception {
		return session.insert("attendMapper.insert_attend", id);
	}

	// 아이디와 월을 받아 출석된 날들을 리스트로 반환함
	public List<String> getEnteredDays_attend(String id, int selectMonth) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("selectMonth", selectMonth);
		
		return session.selectList("attendMapper.getEnteredDays_attend", map);
	}

}
