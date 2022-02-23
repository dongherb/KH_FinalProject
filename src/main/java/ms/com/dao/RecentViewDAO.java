package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.RecentViewDTO;

@Repository
public class RecentViewDAO {

	@Autowired
	private SqlSession session;

	
	// 최근상품 불러오기
	public List<RecentViewDTO> selectAllById_recentView(String id) throws Exception {
		return session.selectList("recentViewMapper.selectAllById_recentView", id);
	}
	
	// 해당 상품의 뷰 기록을 삭제함
	public int deleteOneByProduct_code_recentView(String product_code, String id) throws Exception {

		Map<String , String> map = new HashMap<>();
		map.put("product_code", product_code);
		map.put("id", id);
		
		return session.delete("recentViewMapper.deleteOneByProduct_code_recentView", map);
	}
	
	// 해당 제품의 뷰 기록을 삽입
	public int insertView_recentView(RecentViewDTO dto) {
		return session.insert("recentViewMapper.insertView_recentView", dto);
	}
	
	// 삽입 후 최시순 3개의 데이터 빼고 남겨둠
	public int deleteAllByRow_num_recentView(String id) throws Exception {
		return session.delete("recentViewMapper.deleteAllByRow_num_recentView", id);
	}
	
	
}
