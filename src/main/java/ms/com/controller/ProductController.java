package ms.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dto.BuyerInfoDTO;
import ms.com.dto.MemberDTO;
import ms.com.dto.ProductDTO;
import ms.com.dto.RecentViewDTO;
import ms.com.service.OrderService;
import ms.com.service.ProductService;
import ms.com.service.RecentViewService;
import ms.com.service.ReviewService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService service;
	@Autowired
	private RecentViewService service_recent;
	@Autowired
	private OrderService service_order;
	@Autowired
	private HttpSession session;
	
	
	@RequestMapping("/toProductList")
	public String toProductList(String product_category, int currentPage, Model model) throws Exception{
		List<ProductDTO> list = service.getProductList(product_category, "", "", "", currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(product_category, "", "", currentPage);

		model.addAttribute("list", list);
		model.addAttribute("naviMap", naviMap);
		model.addAttribute("product_category", product_category);
		return "product_manager/productList";
	}
	
	@RequestMapping("/toSearchList")
	public String toSearchList(String product_category, String searchOption, String keyword, int currentPage, Model model) throws Exception{		
		List<ProductDTO> list = service.getSearchList(product_category, searchOption, keyword, currentPage);
		HashMap<String, Object> naviMap = service.getPageNaviBySearch(product_category, searchOption, keyword, currentPage);
		
		model.addAttribute("list", list);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("product_category", product_category);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("keyword", keyword);
		return "product_manager/productList";
	}
	
	@RequestMapping("/toInsertProduct")
	public String toInsertProduct() {
		return "product_manager/insertProduct";
	}
	
	@RequestMapping("/insertProduct.do")
	public String insertProduct(ProductDTO dto, MultipartFile file1, MultipartFile file2) throws Exception{		
		String realPath = session.getServletContext().getRealPath("product_img");
		service.insertProduct(dto, realPath, file1, file2);
		return "redirect:/product/toProductList?product_category=All&currentPage=1";
	}
	
	@RequestMapping("/toCheckCodePopup")
	public String toCheckCodePopup() throws Exception{
		return "product_manager/checkCodePopup";
	}
	
	@RequestMapping("checkCode.do")
	public String checkCode(String product_code, Model model) throws Exception{
		int rs = service.checkCode(product_code);
		model.addAttribute("product_code", product_code);
		
		if(rs == 1) {
			model.addAttribute("rs", "unavailable");
		}else {
			model.addAttribute("rs", "available");
		}
		return "product_manager/checkCodePopup";
	}
	
	@RequestMapping("/toModifyProduct")
	public String toModifyProduct(String product_code, Model model) throws Exception{
		Map<String, Object> map = service.selectOne(product_code);
		model.addAttribute("dto", map.get("dto"));
		return "product_manager/modifyProduct";
	}
	
	@RequestMapping("/modifyProduct.do")
	public String modifyProduct(ProductDTO dto, MultipartFile[] file1, MultipartFile[] file2) throws Exception{
		System.out.println(file1);
		System.out.println(file2);
		
		String realPath = session.getServletContext().getRealPath("product_img");
		service.modifyProduct(dto, realPath, file1, file2);
		return "redirect:/product/toProductList";
	}
	
	@RequestMapping("/deleteProduct.do")
	public String deleteProduct(String product_code) throws Exception{
		int rs = service.deleteProduct(product_code);
		
		if(rs == 1) {	// ??????????????? '????????????'??? ????????? ??????
			service_order.deleteOrderInBasket(product_code);
		}
		return "redirect:/product/toProductList?product_category=All&currentPage=1";
	}
	
	@RequestMapping("/deleteChecked.do")
	public String deleteProduct(String[] chk_Val) throws Exception{
		service.deleteChecked(chk_Val);
		return "redirect:/product/toProductList?product_category=All&currentPage=1";
	}
	
	
	
	//------------------------------------------------
	// ---------- ????????? -----------
	
	// ?????? ???????????? / ???????????? ???????????? ????????????
	@RequestMapping("/toProductShopList")
	public String toProductShopList(String product_category, String detail_category, String keyword, String option, int currentPage, Model model) throws Exception{

		if(product_category.equals("") || product_category.equals("All")) {
			product_category = "??????";
		}
		if(detail_category.equals("") || detail_category.equals("All")) {
			detail_category = "??????";
		}

		List<ProductDTO> list = service.getProductList(product_category, detail_category, keyword, option, currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(product_category, detail_category, keyword, currentPage);
		
		model.addAttribute("productList", list);	// ??????????????? / ??????????????? ????????? ?????????
		model.addAttribute("naviMap", naviMap);	// ?????? ???????????? ?????? ?????????
		model.addAttribute("product_category", product_category);	// ?????? ????????? ?????? ????????????
		model.addAttribute("detail_category", detail_category);	// ?????? ????????? ?????? ?????? ????????????
		model.addAttribute("keyword", keyword);	// ?????? ????????? ???
		model.addAttribute("option", option);	// ????????????
		
		return "product_user/productShopList";
	}
	
	// ??????????????? ???????????? ?????? ????????? ?????????
	@RequestMapping("/toProductDetail")
	public String toProductDetail(String product_code, String done, Model model) throws Exception{
		
		// ?????? ????????? ???????????? DB?????? ???????????? ????????????
		ProductDTO dto = service.selectOne_product(product_code);
		if(dto == null) {
			model.addAttribute("reason", "nullDTO");
			return "error";
		}

		// ????????????????????? ?????? ?????? 4?????? ??????????????? ???????????? // ??????????????? ??????
		List<ProductDTO> recommendedList = service.selectByDetail_category(dto.getDetail_category(), dto.getProduct_code(), "avg_score", 1, 4);
		
		// ????????? ???????????? ????????????
		List<BuyerInfoDTO> buyerAgeList = service.getBuyersInfo(product_code);
		int[] ages = new int[6];
		float[] agePercents = new float[6];
		int totalCount = 0;
		
		for (BuyerInfoDTO buyer : buyerAgeList) {
			if(buyer.getAge() <= 18) {
				ages[0] += buyer.getCount();
			}
			else if(19 <= buyer.getAge() && buyer.getAge() <= 23) {
				ages[1] += buyer.getCount();
			}
			else if(24 <= buyer.getAge() && buyer.getAge() <= 28) {
				ages[2] += buyer.getCount();	
			}
			else if(29 <= buyer.getAge() && buyer.getAge() <= 33) {
				ages[3] += buyer.getCount();
			}
			else if(34 <= buyer.getAge() && buyer.getAge() <= 39) {
				ages[4] += buyer.getCount();
			}
			else {
				ages[5] += buyer.getCount();
			}
			totalCount = ages[0] + ages[1] + ages[2] + ages[3] + ages[4] + ages[5];
		}
		
		for (int i = 0; i < agePercents.length; i++) {
			agePercents[i] = (float) (Math.round( (((float)ages[i] / (float)totalCount) * 100) * 10 ) / 10.0);
		}
		
		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		if(dto_mem != null) {	// ???????????? ???????????? ?????? ??? ??? ?????? ????????????
			service_recent.deleteOneByProduct_code_recentView(product_code, dto_mem.getId());	// ?????? ????????? ??? ?????? ??????
			service_recent.insertView_recentView(new RecentViewDTO(dto_mem.getId(), product_code, dto.getProduct_img(), null));	// ?????? ????????? ??? ?????? ??????	// ?????? -> ?????? ??? ?????????????????? ?????????????????????
			service_recent.deleteAllByRow_num_recentView(dto_mem.getId());	// ?????? ???????????? ??? ?????? ??????????????? 3?????? ????????? ?????????
		
			List<RecentViewDTO> recentViews = service_recent.selectAllById_recentView(dto_mem.getId());
			
			session.setAttribute("rencentViews", recentViews);
		}
		
		model.addAttribute("product", dto);
		model.addAttribute("recommendedList", recommendedList);
		model.addAttribute("buyerAgeList", buyerAgeList);
		model.addAttribute("ages", ages);
		model.addAttribute("agePercents", agePercents);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("done", done);	// ??????????????? ?????? ?????????????????? ??????????????? ??????.

		return "product_user/productDetail";
	}
	
}
