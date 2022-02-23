package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.BuyerInfoDTO;
import ms.com.dto.ProductDTO;

@Repository
public class ProductDAO {
	@Autowired
	private SqlSession session;
	
	// ��ǰ ���
	public List<ProductDTO> selectAll() throws Exception{
		return session.selectList("productMapper.selectAll");
	}
	
	// Ư�� ��ǰ ���� ����
	public ProductDTO selectOne(String product_code) throws Exception{
		return session.selectOne("productMapper.selectOne", product_code);
	}
	
	// ��ǰ ���
	public int insertProduct(ProductDTO dto) throws Exception{
		return session.insert("productMapper.insertProduct", dto);
	}
	
	public int checkCode(String product_code) throws Exception{
		System.out.println(product_code);
		return session.selectOne("productMapper.checkCode", product_code);
	}
	
	// ��ǰ ����
	public int modifyProduct(ProductDTO dto) throws Exception{
		return session.update("productMapper.modifyProduct", dto);
	}
	
	// ��ǰ ����
	public int deleteProduct(String product_code) throws Exception{
		return session.delete("productMapper.deleteProduct", product_code);
	}
	
	public int deleteChecked(String[] chk_Val) throws Exception{
		return session.delete("productMapper.deleteChecked", chk_Val);
	}
	
	// 검색한 제품들 총 데이터 수 반환
	public int getProductCountBySearch(String product_category, String searchOption, String keyword) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("product_category", product_category);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		
		return session.selectOne("productMapper.getProductCountBySearch", map);
	}
	
	// 검색한 범위 안의 데이터 리스트 반환
	public List<ProductDTO> selectProductBySearch(String product_category, String searchOption, String keyword, int startRange, int endRange) throws Exception{
		System.out.println(product_category);
		System.out.println(searchOption);
		System.out.println(keyword);
		
		Map<String, Object> map = new HashMap<>();
		map.put("product_category", product_category);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("productMapper.selectProductBySearch", map);
	}
	
	// 카테고리별로 제품의 총 데이터 수 반환
	public int getProductCountByCategory(String product_category, String detail_category, String keyword) throws Exception{
		
		Map<String, String> map = new HashMap<>();
		map.put("product_category", product_category);
		map.put("detail_category", detail_category);
		map.put("keyword", keyword);
		
		return session.selectOne("productMapper.getProductCountByCategory", map);
	}
	
	// 카테고리별로 해당 범위안의 데이터만 리스트로 가져오기
	public List<ProductDTO> selectProductByCategory(String product_category, String detail_category, String keyword, String option, int startRange, int endRange) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		map.put("product_category", product_category);
		map.put("detail_category", detail_category);
		map.put("keyword", keyword);
		map.put("option", option);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("productMapper.selectProductByCategory", map);
	}

	// 제품의 평균 평점 수정
	public int updateAvgScore_product(String product_code, float avg_score) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("product_code", product_code);
		map.put("avg_score", avg_score);
		
		return session.update("productMapper.updateAvgScore_product", map);
	}
	
	// 리뷰삭제시 제품의 평균평점 복귀 시킴
	public int updateAvgScoreToReturn_product(String product_code, float avg_score) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("product_code", product_code);
		map.put("avg_score", avg_score);
		
		return session.update("productMapper.updateAvgScoreToReturn_product", map);
	}

	// productcode에 대한 정보 가져오기
	public List<ProductDTO> selectByProductCode(List<String> product_codes) throws Exception{
		Map<String,Object> map = new HashMap<>();
		map.put("product_codes", product_codes);
		return session.selectList("productMapper.selectByProductCode", map);
	}

	public List<ProductDTO> selectByDetail_category(String detail_category, String product_code, String option, int startRange, int endRange) throws Exception {

		Map<String, Object> map = new HashMap<>();
		map.put("detail_category", detail_category);
		map.put("product_code", product_code);
		map.put("option", option);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("productMapper.selectByDetail_category", map);
	}
	
	// 해당 제품의 구매자의 나이와 총 인원을 반환함 // 제품DAO와는 관련없지만 편의상 이곳에 들어감 // 제품상세페이지에서 사용됨
	public List<BuyerInfoDTO> getBuyersInfo(String product_code) {
		return session.selectList("productMapper.getBuyersInfo", product_code);
	}

	
}
