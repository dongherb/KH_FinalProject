package ms.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dto.MemberDTO;
import ms.com.dto.OrderDTO;
import ms.com.dto.OrderHistoryDTO;
import ms.com.dto.ProductDTO;
import ms.com.dto.ReviewDTO;
import ms.com.service.MemberService;
import ms.com.service.OrderService;
import ms.com.service.ProductService;
import ms.com.service.ReportService;
import ms.com.service.ReviewService;

@RequestMapping("/review")
@Controller
public class ReviewController {

	@Autowired
	private HttpSession session;
	@Autowired
	private ReviewService service_review;
	@Autowired
	private ProductService service_product;
	@Autowired
	private MemberService service_member;
	@Autowired
	private OrderService service_order;
	@Autowired
	private ReportService service_report;
	
	// 현재 제품에 대한 리뷰 정보 가져오기 // 현재페이지도 고려
	@RequestMapping(value="/getProductReview")
	@ResponseBody
	public Map<String, Object> getProductReview(String product_code, int currentPage) throws Exception {

		List<ReviewDTO> list = service_review.getReviewList(product_code, currentPage);
		HashMap<String, Object> naviMap = service_review.getPageNavi(product_code, currentPage);
		
		// Map으로 넘김
		Map<String, Object> map = new HashMap<>();
		map.put("reviewList", list);
		map.put("naviMap", naviMap);
		
		return map;
	}
	
	// 리뷰작성 페이지로	 // 주문정보를 받아옴
	@RequestMapping(value="/toWriteReview")
	public String toWriteReview(String product_code, int order_seq, String done, Model model) throws Exception {

		model.addAttribute("product_code", product_code);
		model.addAttribute("order_seq", order_seq);
		model.addAttribute("done", done);
		
		return "review/writeReview";
	}
	
	// 리뷰 삽입
	@RequestMapping(value="/insertReviewProc")
	public String insertReviewProc(ReviewDTO dto, MultipartFile file, Model model) throws Exception {

		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String id = dto_mem.getId();
		dto.setId(id);
		
		ProductDTO productExsit = service_product.selectOne_product(dto.getProduct_code());
		
		if(productExsit != null) {
			int exsitCheck = service_review.checkReview_review(id, dto.getProduct_code(), dto.getOrder_seq());
			if(exsitCheck == 0){	// 해당 사용자가 이미 제품을 리뷰하지 않았을 경우
				
				// 사진파일 업로드
				String realPath = session.getServletContext().getRealPath("review_img");	// 파일실제경로

				int rs = service_review.insert_review(dto, realPath, file);
				if(rs == 1) {	// 저장성공시
					
					service_order.updateStatus_order(dto.getOrder_seq(), "리뷰완료");	// 해당주문을 리뷰완료로 변경함
					service_product.updateAvgScore_product(dto);	// 제품의 평점 및 리뷰수 수정
					
					// 해당회원의 포인트 수정
					if(file.isEmpty()) {	// 사진파일이 없다면
						service_member.updatePoint_member(id, 50);	// 50포인트
					} else {	// 있다면
						service_member.updatePoint_member(id, 100);	// 100포인트
					}
					session.setAttribute("loginSession", (MemberDTO)(service_member.getMember(id)));	// 로그인세션 최신화(필수)
					model.addAttribute("done", "done");
				}
				else {			// 저장실패시
					model.addAttribute("done", "fail");
				}
			}
			else {	// 이미 리뷰가 존재할 경우
				model.addAttribute("done", "exsit");
			}
		}
		else {	// 제품이 없을 경우
			model.addAttribute("done", "productDelete");
		}
		
		return "redirect:/review/toWriteReview?product_code="+dto.getProduct_code()+"&order_seq="+dto.getOrder_seq();
	}
	
	// 리뷰정보를 보여주는 팝업창으로
	@RequestMapping(value="/toShowReviewPapup")
	public String toShowReviewPapup(int order_seq, Model model) throws Exception {
		
		ReviewDTO dto_review = service_review.getReviewByOrder_seq(order_seq);
		
		if(dto_review == null) {	// 리뷰정보가 없을 시 // 오류인 경우
			model.addAttribute("exsit", "none");
		}
		else {	// 리뷰존재 시
			ProductDTO dto_product = service_product.selectOne_product(dto_review.getProduct_code());	// 해당리뷰의 제품정보 가져오기
			
			model.addAttribute("reviewDTO", dto_review);
			model.addAttribute("productDTO", dto_product);
		}

		return "/review/showReviewPapup";
	}
	
	// 리뷰 삭제
	@RequestMapping(value="/deleteReviewProc")
	public String deleteReviewProc(int review_seq) throws Exception{
		
		ReviewDTO deleted_dto_review = service_review.selectReviewByReview_seq(review_seq);
		String writer_id = deleted_dto_review.getId();
		int rs = service_review.delete_review(review_seq);

		// 리뷰삭제 시
		if(rs == 1) {
			service_member.addReported_count(writer_id);
			service_product.updateAvgScoreToReturn_product(deleted_dto_review);	// 반영한 평점을 지움

			// 해당회원의 포인트 수정	
			if(deleted_dto_review.getReview_img() == null) {	// 사진파일이 없다면
				service_member.descPoint_member(writer_id, 50);	// 50포인트 감소
			} else {	// 있다면
				service_member.descPoint_member(writer_id, 100);	// 100포인트 감소
			}
		}

		return "redirect:/report/toReportList?currentPage=1";
	}
	
	// 체크된 리뷰 삭제
	@RequestMapping("/deleteChecked.do")
	public String deleteProduct(String[] chk_Val) throws Exception{
		
		for (int i = 0; i < chk_Val.length; i++) {

			int report_seq = Integer.parseInt(chk_Val[i]);	// String 값을 int로 변환후 넘겨줌	// 신고번호
			int review_seq = service_report.selectReview_seqByReport_seq(report_seq);		// 해당 신고번호의 리뷰번호

			// 해당리뷰 정보 불러오기
			ReviewDTO deleted_dto_review = service_review.selectReviewByReview_seq(review_seq);
			int rs = service_review.delete_review(review_seq);		// 해당 리뷰 삭제

			if(rs == 1) {	// 해당리뷰가 존재하여 삭제에 성공했다면
				
				String writer_id = deleted_dto_review.getId();	// 해당리뷰의 글쓴이 가져오기
				service_product.updateAvgScoreToReturn_product(deleted_dto_review);	// 반영한 평점을 지움

				// 해당회원의 포인트 수정	
				if(deleted_dto_review.getReview_img() == null) {	// 사진파일이 없다면
					service_member.descPoint_member(writer_id, 50);	// 50포인트 감소
				} else {	// 있다면
					service_member.descPoint_member(writer_id, 100);	// 100포인트 감소
				}
			}
		}
		return "redirect:/report/toReportList?currentPage=1";
	}
	
	// 리뷰 존재 여부 확인
	@RequestMapping("/checkReviewExist.do")
	public String checkReviewExist(int review_seq, Model model) throws Exception{
		int rs = service_review.checkReviewExist(review_seq);
		
		if(rs == 1) {
			model.addAttribute("rs", 1);
			return "redirect:/report/toReportList?currentPage=1";
		} else {
			model.addAttribute("rs", 0);
			return "redirect:/report/toReportList?currentPage=1";
		}
	}
	
}
