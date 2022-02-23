package ms.com.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dao.RecentViewDAO;
import ms.com.dao.ReviewDAO;
import ms.com.dto.ReviewDTO;

@Service
public class ReviewService {

	@Autowired
	private ReviewDAO dao;
	
	//-------------------- 페이징부분 -------------------------------------------
	// 페이징에 필요한 변수
	private int recordCntPage = 5;	// 하나의 페이지에 보여질 데이터 수
	private int naviCntPage = 5;	// 보여질 네비게이션(페이지) 범위
	
	// 현재 페이지에 대한 안전 장치와 총 페이지 수를 저장하고 있는 메서드 / [0]: 안전장치된 현재페이지, [1]: 총 페이지 수
	private int[] getPageInfromations(String product_code, int currentPage) throws Exception {

		int recordTototalCnt = dao.getReviewCountByProduct(product_code);	// 해당 카테고리의 전체 데이터의 수
		
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
	public HashMap<String, Object> getPageNavi(String product_code, int currentPage) throws Exception {

		currentPage = getPageInfromations(product_code, currentPage)[0];	// 현재페이지 안전장치
		int pageTotalCnt = getPageInfromations(product_code, currentPage)[1];	// 총 페이지 수

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
	public List<ReviewDTO> getReviewList(String product_code, int currentPage) throws Exception{
		
		int recordTototalCnt = dao.getReviewCountByProduct(product_code);	// 해당 조건에 맞는 데이터의 수
		currentPage = getPageInfromations(product_code, currentPage)[0]; 	// 현재페이지로 일어난 오류를 방지

		//----------------------------------------------------------------------------
		
		int startRange = ((currentPage - 1) * recordCntPage) + 1;	// 보여지는 데이터 시작
		int endRange = currentPage * recordCntPage;					// 보여지는 데이터 끝
		if(endRange >= recordTototalCnt) {	// 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<ReviewDTO> list = dao.selectReviewByProduct(product_code, startRange, endRange);	// 범위에있는 값을 list로 가져옴
		return list;
	}
	
	// ----- 페이징 관련 메서드 끝 ---------------
	//--------------------------------------
	
	public List<ReviewDTO> selectAll() throws Exception{
		return dao.selectAll();
	}
	
	// review_seq로 신고당한 하나의 리뷰 정보 불러오기
	public ReviewDTO getOneReview(int review_seq) throws Exception{
		return dao.getOneReview(review_seq);
	}
	
	// 리뷰데이터 입력 및 사진 업로드
	public int insert_review(ReviewDTO dto, String realPath, MultipartFile file) throws Exception {
		
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {	// 폴더없을시 새로생성
			realPathFile.mkdir();
		}
		
		if(!file.isEmpty()) {	// 파일이 비어있지 않을 시
			String ori_name = file.getOriginalFilename();
			String sys_name = UUID.randomUUID() + "_" + ori_name;

			file.transferTo(new File(realPathFile + File.separator + sys_name));
			dto.setReview_img(sys_name);	//저장된 실제 파일이름을 setter 주입
		}

		return dao.insert_review(dto);
	}
	
	// 리뷰 삭제
	public int delete_review(int review_seq) throws Exception{
		return dao.delete_review(review_seq);
	}
	
	// 체크된 리뷰 삭제
	public int deleteChecked(String[] chk_Val) throws Exception {
		return dao.deleteChecked(chk_Val);
	}
	
	// 리뷰 존재 여부 확인
	public int checkReviewExist(int review_seq) throws Exception {
		return dao.checkReviewExist(review_seq);
	}
	
	// 해당제품에 이미 리뷰를 작성했는지 검사
	public int checkReview_review(String id, String product_code, int order_seq) throws Exception {
		return dao.checkReview_review(id, product_code, order_seq);
	}

	// 주문번호로 리뷰정보 불러오기
	public ReviewDTO getReviewByOrder_seq(int order_seq) throws Exception {
		return dao.getReviewByOrder_seq(order_seq);
	}
	
	// 리뷰번호로 리뷰정보 불러오기
	public ReviewDTO selectReviewByReview_seq(int review_seq) throws Exception {
		return dao.selectReviewByReview_seq(review_seq);
	}
	
	// 이미지가 있는 범위안의 리뷰를 리스트에 담기 (내림차정렬 조건컬럼)
	public List<ReviewDTO> selectReviewWithImg(String option, int startRange, int endRange) throws Exception {
		return dao.selectReviewWithImg(option, startRange, endRange);
	}

}
