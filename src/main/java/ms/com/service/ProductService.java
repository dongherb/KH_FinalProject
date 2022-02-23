package ms.com.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dao.ProductDAO;
import ms.com.dto.BuyerInfoDTO;
import ms.com.dto.ProductDTO;
import ms.com.dto.ReviewDTO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO productDao;
	
	public List<ProductDTO> selectAll() throws Exception{
		return productDao.selectAll();
	}
	
	public Map<String, Object> selectOne(String product_code) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("dto", productDao.selectOne(product_code));
		return map;
	}
	
	// map으로가 아닌 productDTO 형으로 가져오기
	public ProductDTO selectOne_product(String product_code) throws Exception{
		return productDao.selectOne(product_code);
	}
	
	public int insertProduct(ProductDTO dto, String realPath, MultipartFile file1, MultipartFile file2) throws Exception{
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {
			realPathFile.mkdir();
		}
		
//		for(MultipartFile f1 : file1) {
			if(!file1.isEmpty()) {
				String ori_name = file1.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
				System.out.println(sys_name);
				
				file1.transferTo(new File(realPath + File.separator + sys_name));
				dto.setProduct_img(sys_name);
			}
//		}
		
//		for(MultipartFile f2 : file2) {
			if(!file2.isEmpty()) {
				String ori_name = file2.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
 				System.out.println(sys_name);
				
				file2.transferTo(new File(realPath + File.separator + sys_name));
				dto.setDetail_img(sys_name);
			}
//		}
		return productDao.insertProduct(dto);
	}
	
	public int checkCode(String product_code) throws Exception{
		return productDao.checkCode(product_code);
	}
	
	public int modifyProduct(ProductDTO dto, String realPath, MultipartFile[] file1, MultipartFile[] file2) throws Exception{
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {
			realPathFile.mkdir();
		}
		
		for(MultipartFile f1 : file1) {
			if(!f1.isEmpty()) {
				String ori_name = f1.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
				System.out.println(sys_name);
				
				f1.transferTo(new File(realPath + File.separator + sys_name));
				dto.setProduct_img(sys_name);
			}
		}
		
		for(MultipartFile f2 : file2) {
			if(!f2.isEmpty()) {
				String ori_name = f2.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
 				System.out.println(sys_name);
				
				f2.transferTo(new File(realPath + File.separator + sys_name));
				dto.setDetail_img(sys_name);
			}
		}
		return productDao.modifyProduct(dto);
	}
	
	public int deleteProduct(String product_code) throws Exception{
		return productDao.deleteProduct(product_code);
	}
	
	public int deleteChecked(String[] chk_Val) throws Exception{
		return productDao.deleteChecked(chk_Val);
	}
	
	//-------------------- 페이징부분 -------------------------------------------
	// 페이징에 필요한 변수
	private int recordCntPage = 20;	// 하나의 페이지에 보여질 데이터 수
	private int naviCntPage = 5;	// 보여질 네비게이션(페이지) 범위
	
	// 현재 페이지에 대한 안전 장치와 총 페이지 수를 저장하고 있는 메서드 / [0]: 안전장치된 현재페이지, [1]: 총 페이지 수
	private int[] getPageInfromations(String product_category, String detail_category, String keyword, int currentPage) throws Exception {

		int recordTototalCnt = productDao.getProductCountByCategory(product_category, detail_category, keyword);	// 해당 카테고리의 전체 데이터의 수
		
		int pageTotalCnt;	// 총 페이지 수
		if( (recordTototalCnt % recordCntPage) == 0 ) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		}
		else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}
		
		// 현재 페이지에 대한 안전 장치
		if(currentPage >= pageTotalCnt) {	// currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		}
		else if(currentPage <= 0) {			// currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}
		
		int[] pageInfromations = {currentPage, pageTotalCnt};
		
		return pageInfromations;
	}
	
	// 검색시 사용될 메서드
	private int[] getSearchPageInfromations(String product_category, String searchOption, String keyword, int currentPage) throws Exception {

		int recordTototalCnt = productDao.getProductCountBySearch(product_category, searchOption, keyword);	// 검색한 전체 데이터의 수
		
		int pageTotalCnt;	// 총 페이지 수
		if( (recordTototalCnt % recordCntPage) == 0 ) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		}
		else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}
		
		// 현재 페이지에 대한 안전 장치
		if(currentPage >= pageTotalCnt) {	// currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		}
		else if(currentPage <= 0) {			// currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}
		
		int[] pageInfromations = {currentPage, pageTotalCnt};
		
		return pageInfromations;
	}
	
	// 해쉬맵에 페이지에 대한 정보를 저장하는 매서드
	public HashMap<String, Object> getPageNavi(String product_category, String detail_category, String keyword, int currentPage) throws Exception {

		currentPage = getPageInfromations(product_category, detail_category, keyword, currentPage)[0];	// 현재페이지 안전장치
		int pageTotalCnt = getPageInfromations(product_category, detail_category, keyword, currentPage)[1];	// 총 페이지 수

		//----------------------------------------------------------------------------
		
		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ( (currentPage-1) / naviCntPage ) * naviCntPage + 1;	// 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1);		// 아래 표시될 끝나는 페이지
		if(endNavi >= pageTotalCnt) {	// 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}
		
		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true;	// 이전 버튼
		boolean needNext = true;	// 다음 버튼
		
		if(startNavi <= 1)	// 처음일때 이전버튼 없음
			needPrev = false;
		if(endNavi >= pageTotalCnt)	// 마지막일때 다음버튼 없음
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
	public HashMap<String, Object> getPageNaviBySearch(String product_category, String searchOption, String keyword, int currentPage) throws Exception {

		currentPage = getSearchPageInfromations(product_category, searchOption, keyword, currentPage)[0];	// 현재페이지 안전장치
		int pageTotalCnt = getSearchPageInfromations(product_category, searchOption, keyword, currentPage)[1];	// 총 페이지 수

		//----------------------------------------------------------------------------
		
		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ( (currentPage-1) / naviCntPage ) * naviCntPage + 1;	// 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1);		// 아래 표시될 끝나는 페이지
		if(endNavi >= pageTotalCnt) {	// 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}
		
		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true;	// 이전 버튼
		boolean needNext = true;	// 다음 버튼
		
		if(startNavi <= 1)	// 처음일때 이전버튼 없음
			needPrev = false;
		if(endNavi >= pageTotalCnt)	// 마지막일때 다음버튼 없음
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
	
	// 현재페이지를 기반으로 불러올 제품를 List로 반환함
	public List<ProductDTO> getProductList(String product_category, String detail_category, String keyword, String option, int currentPage) throws Exception{
		
		int recordTototalCnt = productDao.getProductCountByCategory(product_category, detail_category, keyword);	// 해당 조건에 맞는 데이터의 수
		currentPage = getPageInfromations(product_category, detail_category, keyword, currentPage)[0]; 	// 현재페이지로 일어난 오류를 방지

		//----------------------------------------------------------------------------
		
		int startRange = ((currentPage - 1) * recordCntPage) + 1;	// 보여지는 데이터 시작
		int endRange = currentPage * recordCntPage;					// 보여지는 데이터 끝
		if(endRange >= recordTototalCnt) {	// 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<ProductDTO> list = productDao.selectProductByCategory(product_category, detail_category, keyword, option, startRange, endRange);	// 범위에있는 값을 list로 가져옴
		return list;
	}
	
	// 검색시 불러올 제품 List
	public List<ProductDTO> getSearchList(String product_category, String searchOption, String keyword, int currentPage) throws Exception{
		System.out.println(product_category);
		
		int recordTototalCnt = productDao.getProductCountBySearch(product_category, searchOption, keyword);
		currentPage = getSearchPageInfromations(product_category, searchOption, keyword, currentPage)[0];
		
		int startRange = ((currentPage - 1) * recordCntPage) + 1;
		int endRange = currentPage * recordCntPage;
		if(endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}
		
		List<ProductDTO> list = productDao.selectProductBySearch(product_category, searchOption, keyword, startRange, endRange);
		return list;
	}
	
	// ----------------------------------------------------------------------------------------
	
	// 리뷰등록시 제품의 평균평점 계산 후 수정
	public int updateAvgScore_product(ReviewDTO dto) throws Exception {
		
		float score = dto.getScore();	// 기본 초기화
		float avg_score = score;
		
		// 해당 제품의 정보를 가져옴
		ProductDTO dto_temp = productDao.selectOne(dto.getProduct_code());

		int review_count_temp = dto_temp.getReview_count();	// 해당 제품의 총 리뷰수
		if(review_count_temp != 0) {	// 리뷰수가 0이 아니라면
			
			float avg_score_temp = dto_temp.getAvg_score();	// 해당 평균 평점
			
			// 기존의 평균평점이 존재할 시 새로 들어갈 평균평점 계산식
			avg_score = ((avg_score_temp * review_count_temp) + score) / (review_count_temp + 1);
		}
		return productDao.updateAvgScore_product(dto.getProduct_code(), avg_score);
	}
	
	// 리뷰삭제시 제품의 평균평점 복귀 시킴
	public int updateAvgScoreToReturn_product(ReviewDTO dto) throws Exception {
		
		float score = dto.getScore();	// 기본 초기화
		float avg_score = 0;
		
		// 해당 제품의 정보를 가져옴
		ProductDTO dto_temp = productDao.selectOne(dto.getProduct_code());
		
		int review_count_temp = dto_temp.getReview_count();	// 해당 제품의 총 리뷰수
		
		if(review_count_temp > 1) {		// 해당 제품의 리뷰수가 0보다 클때
			
			float avg_score_temp = dto_temp.getAvg_score();	// 해당 평균 평점
			
			avg_score = ((avg_score_temp * review_count_temp) - score) / (review_count_temp - 1);
		}

		return productDao.updateAvgScoreToReturn_product(dto.getProduct_code(), avg_score);
	}
	
	// 제품코드들로 해당 제품들을 정보를 리스트에 담기
	public List<ProductDTO> selectByProductCode(List<String> product_codes) throws Exception{
		return productDao.selectByProductCode(product_codes);
	}
	
	//  카테고리, 정렬순을 입력하여 특정 범위안의 제품데이터 가져오기	// 메인 페이지에서 활용될 예정
	public List<ProductDTO> selectProductByCategory(String product_category,String option, int startRange, int endRange) throws Exception {
		return productDao.selectProductByCategory(product_category, "", "", option, startRange, endRange);
	}
	
	// 세부카테고리, 정렬순을 입력하여 특정 범위안의 제품데이터 가져오기		// 제품세부페이지에서 활용
	public List<ProductDTO> selectByDetail_category(String detail_category, String product_code, String option, int startRange, int endRange) throws Exception {
		return productDao.selectByDetail_category(detail_category, product_code, option, startRange, endRange);
	}

	// 해당 제품의 구매자의 나이와 총 인원을 반환함 // 제품DAO와는 관련없지만 편의상 이곳에 들어감
	public List<BuyerInfoDTO> getBuyersInfo(String product_code) throws Exception {
		return productDao.getBuyersInfo(product_code);
	}
	
}
