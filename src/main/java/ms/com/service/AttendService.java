package ms.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.AttendDAO;
import ms.com.dto.CalendarInfoDTO;

@Service
public class AttendService {

	@Autowired
	private AttendDAO dao;

	// 현재 월을 기반으로 필요한 캘린더 정보 가져오기
	public CalendarInfoDTO getCalendarInfo(int selectMonth) throws Exception {
		return dao.getCalendarInfo(selectMonth);
	}

	// 현재날짜에 출석이 존재하는지 확인
	public boolean checkEnter_attend(String id) throws Exception {
		return dao.checkEnter_attend(id);
	}

	// 해당아이디 출석 저장
	public int insert_attend(String id) throws Exception {
		return dao.insert_attend(id);
	}

	// 아이디와 월을 받아 출석된 날들을 리스트로 반환함
	public List<String> getEnteredDays_attend(String id, int selectMonth) throws Exception {
		return dao.getEnteredDays_attend(id, selectMonth);
	}

}
