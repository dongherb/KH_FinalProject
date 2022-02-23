package ms.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.RecentViewDAO;
import ms.com.dto.RecentViewDTO;

@Service
public class RecentViewService {

	@Autowired
	private RecentViewDAO dao;
	
	// 최근상품 불러오기
	public List<RecentViewDTO> selectAllById_recentView(String id) throws Exception {
		return dao.selectAllById_recentView(id);
	}
	
	// 해당 상품의 뷰 기록을 삭제함
	public int deleteOneByProduct_code_recentView(String product_code, String id) throws Exception {
		return dao.deleteOneByProduct_code_recentView(product_code, id);
	}
	
	// 해당 제품의 뷰 기록을 삽입
	public int insertView_recentView(RecentViewDTO dto) {
		return dao.insertView_recentView(dto);
	}
	
	// 삽입 후 최시순 3개의 데이터 빼고 남겨둠
	public int deleteAllByRow_num_recentView(String id) throws Exception {
		return dao.deleteAllByRow_num_recentView(id);
	}
	
}
