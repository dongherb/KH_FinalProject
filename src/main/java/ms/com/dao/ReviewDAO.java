package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.ReviewDTO;

@Repository
public class ReviewDAO {
	@Autowired
	private SqlSession session;
	
	// 해당 제품에 대한 리뷰의 총 데이터수 가져오기
	public int getReviewCountByProduct(String product_code) throws Exception {
		return session.selectOne("reviewMapper.getReviewCountByProduct", product_code);
	}
	
	// 해당 범위안의 제품에 대한 리뷰만 리스트로 가져오기
	public List<ReviewDTO> selectReviewByProduct(String product_code, int startRange, int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("product_code", product_code);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("reviewMapper.selectReviewByProduct", map);
	}
	
	// 모든 리뷰 가져오기
	public List<ReviewDTO> selectAll() throws Exception{
		return session.selectList("reviewMapper.selectAll");
	}

	// 하나의 리뷰 가져오기
	public ReviewDTO getOneReview(int review_seq) throws Exception{
		return session.selectOne("reviewMapper.getOneReview", review_seq);
	}

	// 리뷰정보를 DB에 삽입함
	public int insert_review(ReviewDTO dto) throws Exception {
		return session.insert("reviewMapper.insert_review", dto);
	}
	
	// 리뷰 DB에서 삭제
	public int delete_review(int review_seq) throws Exception{
		return session.delete("reviewMapper.delete_review", review_seq);
	}
	
	// 관리자 페이지에서 체크된 리뷰 삭제
	public int deleteChecked(String[] chk_Val) throws Exception {
		return session.delete("reviewMapper.deleteChecked", chk_Val);
	}
	
	// 리뷰 존재 여부 확인
	public int checkReviewExist(int review_seq) throws Exception {
		return session.selectOne("reviewMapper.checkReviewExist", review_seq);
	}

	// 해당제품에 이미 리뷰를 작성했는지 검사
	public int checkReview_review(String id, String product_code, int order_seq) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("product_code", product_code);
		map.put("order_seq", order_seq);
		
		return session.selectOne("reviewMapper.checkReview_review", map);
	}

	// 주문번호로 리뷰정보 불러오기
	public ReviewDTO getReviewByOrder_seq(int order_seq) throws Exception {
		return session.selectOne("reviewMapper.getReviewByOrder_seq", order_seq);
	}
	
	// 리뷰번호로 리뷰정보 불러오기
	public ReviewDTO selectReviewByReview_seq(int review_seq) {
		return session.selectOne("reviewMapper.selectReviewByReview_seq", review_seq);
	}

	// 이미지가 있는 범위안의 리뷰를 리스트에 담기 (최신순)
	public List<ReviewDTO> selectReviewWithImg(String option, int startRange, int endRange) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("option", option);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("reviewMapper.selectReviewWithImg", map);
	}

}
