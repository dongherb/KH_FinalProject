package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.ReportDTO;

@Repository
public class ReportDAO {
	@Autowired
	private SqlSession session;
	
	public List<ReportDTO> selectAll(int startRange, int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		return session.selectList("reportMapper.selectAll", map);
	}
	
	// 같은 아이디로 같은 리뷰에 이미 신고가 존재하는지 파악
	public int alreadyReport(ReportDTO dto) throws Exception{
		return session.selectOne("reportMapper.alreadyReport", dto);
	}

	public int insertReport(ReportDTO dto) throws Exception {
		return session.insert("reportMapper.insertReport", dto);
	}

	public int deleteReport(int report_seq) throws Exception {
		return session.delete("reportMapper.deleteReport", report_seq);
	}

	public int deleteChecked(String[] chk_Val) throws Exception {
		return session.delete("reportMapper.deleteChecked", chk_Val);
	}
	
	// 신고번호의 리뷰번호를 반환
	public int selectReview_seqByReport_seq(int report_seq) throws Exception {
		return session.selectOne("reportMapper.selectReview_seqByReport_seq", report_seq);
	}

	public int getReportCount() throws Exception {
		return session.selectOne("reportMapper.getReportCount");
	}

	// 검색한 신고들 총 데이터 수 반환
	public int getReportCountBySearch(String category, String searchOption, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);

		return session.selectOne("reportMapper.getReportCountBySearch", map);
	}

	// 검색한 범위 안의 데이터 리스트 반환
	public List<ReportDTO> selectReportBySearch(String category, String searchOption, String keyword, int startRange,
			int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		return session.selectList("reportMapper.selectReportBySearch", map);
	}

}
