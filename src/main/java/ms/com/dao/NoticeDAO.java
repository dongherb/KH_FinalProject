package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.NoticeDTO;

@Repository
public class NoticeDAO {
	@Autowired
	private SqlSession session;
	
	public List<NoticeDTO> selectAll(int startRange, int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		return session.selectList("noticeMapper.selectAll", map);
	}

	public NoticeDTO selectOne(int notice_seq) throws Exception {
		return session.selectOne("noticeMapper.selectOne", notice_seq);
	}

	public int insertNotice(NoticeDTO dto) throws Exception {
		return session.insert("noticeMapper.insertNotice", dto);
	}

	public int modifyNotice(NoticeDTO dto) throws Exception {
		System.out.println(dto.getNotice_seq());
		System.out.println(dto.getTitle());
		System.out.println(dto.getContent());
		System.out.println(dto.getNotice_img());
		System.out.println(dto.getWritten_date());
		return session.update("noticeMapper.modifyNotice", dto);
	}

	public int deleteNotice(int notice_seq) throws Exception {
		return session.delete("noticeMapper.deleteNotice", notice_seq);
	}
	
	public int deleteChecked(String[] chk_Val) throws Exception{
		return session.delete("noticeMapper.deleteChecked", chk_Val);
	}

	public int getNoticeCount() throws Exception {
		return session.selectOne("noticeMapper.getNoticeCount");
	}

	// 검색한 제품들 총 데이터 수 반환
	public int getNoticeCountBySearch(String keyword) throws Exception {
		return session.selectOne("noticeMapper.getNoticeCountBySearch", keyword);
	}

	// 검색한 범위 안의 데이터 리스트 반환
	public List<NoticeDTO> selectNoticeBySearch(String keyword, int startRange, int endRange) throws Exception {
		System.out.println(keyword);

		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		return session.selectList("noticeMapper.selectNoticeBySearch", map);
	}
}
