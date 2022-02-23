package ms.com.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.AdvertisementDTO;
import ms.com.dto.MemberDTO;
import ms.com.dto.ProductDTO;
import ms.com.dto.RecentViewDTO;
import ms.com.dto.ReviewDTO;
import ms.com.service.AdvertisementService;
import ms.com.service.ForecastDataService;
import ms.com.service.ProductService;
import ms.com.service.RecentViewService;
import ms.com.service.ReviewService;

@Controller
public class HomeController {

	@Autowired
	private HttpSession session;
	@Autowired
	private ProductService service_product;
	@Autowired
	private ReviewService service_review;
	@Autowired
	private RecentViewService service_recent;
	@Autowired
	private ForecastDataService service_forecast;
	@Autowired
	private AdvertisementService service_advermt;
	
	// 메인페이지
	@RequestMapping(value = "/")
	public String home(Model model) throws Exception {
		
		// 기상청 제공한 날씨 데이터 불러오기
		Map<String, String> forcastMap;
		
		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		
		// 신상품 정보 최대 8개 (카테고리: 전체, 순서: 최신등록순)
		List<ProductDTO> newArrivals = service_product.selectProductByCategory("전체", "insert_date", 1, 8);
		
		// 베스트 상품 정보 최대 8개 (카테고리: 전체, 순서 : 평점순)
		List<ProductDTO> bestItems = service_product.selectProductByCategory("전체", "avg_score", 1, 8);
		
		// 신발 상품 정보 최대 8개(카테고리: 신발, 순서: 리뷰수)
		List<ProductDTO> shoes = service_product.selectProductByCategory("신발", "review_count", 1, 8);
		
		// 리뷰 정보 최대 4개 (조건 : 사진이 첨부됨, 순서: 최신순)
		List<ReviewDTO> latestReviews = service_review.selectReviewWithImg("written_date", 1, 4);
		
		// 날씨에 따른 광고정보 담기
		List<AdvertisementDTO> advermtNormal = service_advermt.selectListByForecast("normal");
		List<AdvertisementDTO> advermtHot = service_advermt.selectListByForecast("hot");
		List<AdvertisementDTO> advermtCold = service_advermt.selectListByForecast("cold");
		List<AdvertisementDTO> advermtRain = service_advermt.selectListByForecast("rain");

		//--------------------------------------------
		// 사이드바에 정보담기
		if(dto_mem != null) {	// 로그인이 되어있을 경우에만
			// 사이드바에 담을 정보
			List<RecentViewDTO> recentViews = service_recent.selectAllById_recentView(dto_mem.getId());
			session.setAttribute("rencentViews", recentViews);
		}
		
		//---------------------------------
		
		if(dto_mem != null) {	// 로그인한 사용자가 있을 경우
			// 사용자의 주소를 담기
			forcastMap = service_forecast.makeSutiedMap(dto_mem.getAddress());	
		}
		else {	// 로그인한 사용자가 없을 경우
			// null 값으로 담기
			forcastMap = service_forecast.makeSutiedMap(null);	
		}

		String jsonForecast = service_forecast.getData(
									forcastMap.get("base_date"),
									forcastMap.get("base_time"),
									forcastMap.get("plusTime"),
									forcastMap.get("nx"),
									forcastMap.get("ny")
								);
		
		model.addAttribute("firstAddress", forcastMap.get("firstAddress"));
		model.addAttribute("jsonForecast", jsonForecast);
		
		model.addAttribute("advermtNormal", advermtNormal);
		model.addAttribute("advermtHot", advermtHot);
		model.addAttribute("advermtCold", advermtCold);
		model.addAttribute("advermtRain", advermtRain);
		
		model.addAttribute("newArrivals", newArrivals);
		model.addAttribute("bestItems", bestItems);
		model.addAttribute("shoes", shoes);
		model.addAttribute("latestReviews", latestReviews);
		
		return "home";
	}

	// 임시 기능홈 (tempHome.jsp)
	@RequestMapping("/toTempHome")
	public String toTempHome() {
		return "tempHome";
	}
	
	//관리자페이지에서 문의글 확인하기
	@RequestMapping("/toManagerPage")
	public String toManagerPage(Model model)throws Exception {
		//	List<EnquiryDTO> list = service.selectAll();
		//	model.addAttribute("list", list);
		return "/managerHome";
	}
	
}
