package ms.com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.MemberDTO;
import ms.com.dto.OrderDTO;
import ms.com.dto.ProductDTO;
import ms.com.service.MemberService;
import ms.com.service.OrderService;
import ms.com.service.PaymentService;
import ms.com.service.ProductService;

@Controller
@RequestMapping(value = "/order")
public class OrderController {

	@Autowired
	HttpSession session;
	@Autowired
	OrderService service;
	@Autowired
	ProductService productService;
	@Autowired
	PaymentService paymentService;
	@Autowired
	MemberService memberService;
	
	// 장바구니넣기 시 거래상태 '장바구니'로 장바구니에 존재하는 주문을 구별할 예정
	@RequestMapping(value = "/createOrderToBasket")
	public String createOrderToBasket(OrderDTO dto, Model model) throws Exception{
		
		// 세션에서 담고있는 OrderDTO를 삭제함 / 구매하기시 주문정보 임시저장용
		session.removeAttribute("tempOrderDTO");
		
		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		dto.setId(dto_mem.getId());

		int rs = service.insert_unpaidOrder(dto);	// 미지불된 주문생성	// 장바구니에 담길 주문
		if(rs == 1) {		// 성공시
			model.addAttribute("done", "done");
		}
		else {				// 실패시
			model.addAttribute("done", "fail");
		}
		
		return "redirect:/product/toProductDetail?product_code="+dto.getProduct_code();
	}
	
	// 장바구니에서 결제페이지로
	@RequestMapping(value = "/toOrder")
	public String toOrder(Model model) throws Exception {
		
		String id = ((MemberDTO)session.getAttribute("loginSession")).getId();	// 로그인세션 새로고침	// 포인트가 달라졌을 수도 있음
		session.setAttribute("loginSession", memberService.getMember(id));
		
		// 세션에서 담고있는 OrderDTO를 삭제함 / 구매하기시 주문정보 임시저장용
		session.removeAttribute("tempOrderDTO");

		List<OrderDTO> list = service.selectAll(id);
		List<String> product_codes = new ArrayList<>();

		for (OrderDTO orderDTO : list) {
			product_codes.add(orderDTO.getProduct_code());
		}

		// order.jsp에서 list 받아오려고 사용
		model.addAttribute("list", list);

		// 제품코드 리스트(product_codes)를 가져다가 제품코드에 맞는 정보들을 반환함
		List<ProductDTO> product_list = productService.selectByProductCode(product_codes);
		model.addAttribute("product_list", product_list);

		int totalPrice = 0;

		for (OrderDTO orderDTO : list) {
			for (ProductDTO productDTO : product_list) {
				if (productDTO.getProduct_code().equals(orderDTO.getProduct_code())) {
					float price = (productDTO.getPrice()
							- ((float) (productDTO.getDiscount()) / (float) (100) * (float) (productDTO.getPrice())))
							* orderDTO.getQuantity();
					totalPrice += price;
					break;
				}
			}
		}

		model.addAttribute("totalPrice", totalPrice);
		return "/payment/order";
	}
	
	// 구매하기 시 결제 후에 결제 완료된 주문 생성 // 결제페이지로
	@RequestMapping(value = "/createOrderToPayment")
	public String createOrderToPayment(OrderDTO dto, Model model) throws Exception{

		String id = ((MemberDTO)session.getAttribute("loginSession")).getId();	// 로그인세션 새로고침	// 포인트가 달라졌을 수도 있음
		session.setAttribute("loginSession", memberService.getMember(id));
		
		// 세션에서 OrderDTO를 담고있게함 / 구매하기시 주문정보 임시저장용
		session.setAttribute("tempOrderDTO", dto);
		
		// 리스트에 직접 하나만 추가함
		List<OrderDTO> list = new ArrayList<>();
		list.add(dto);
		
		List<String> product_codes = new ArrayList<>();

		for (OrderDTO orderDTO : list) {
			product_codes.add(orderDTO.getProduct_code());
		}

		// order.jsp에서 list 받아오려고 사용
		model.addAttribute("list", list);

		// 제품코드 리스트(product_codes)를 가져다가 제품코드에 맞는 정보들을 반환함
		List<ProductDTO> product_list = productService.selectByProductCode(product_codes);
		model.addAttribute("product_list", product_list);

		int totalPrice = 0;

		for (OrderDTO orderDTO : list) {
			for (ProductDTO productDTO : product_list) {
				if (productDTO.getProduct_code().equals(orderDTO.getProduct_code())) {
					float price = (productDTO.getPrice()
							- ((float) (productDTO.getDiscount()) / (float) (100) * (float) (productDTO.getPrice())))
							* orderDTO.getQuantity();
					totalPrice += price;
					break;
				}
			}
		}

		model.addAttribute("totalPrice", totalPrice);
		return "/payment/order";
	}
	
	
	// 관리자 페이지 관련 -----------------------------------------------
	
	// 관리자 페이지 주문 리스트로 이동
	@RequestMapping("/toOrderList")
	public String toOrderList(int currentPage, Model model) throws Exception {
		List<OrderDTO> list1 = service.managerOrderList(currentPage);
		HashMap<String, Object> naviMap = service.getManagerPageNavi(currentPage);

		ArrayList<ProductDTO> list2 = new ArrayList<>();
		for(int i = 0; i < list1.size(); i++) {
			ProductDTO dto = productService.selectOne_product(list1.get(i).getProduct_code());
			list2.add(dto);
		}
		
		model.addAttribute("order_list", list1);
		model.addAttribute("nameList", list2);
		model.addAttribute("naviMap", naviMap);
		return "order_manager/orderList";
	}

	// 배송 현황 변경
	@RequestMapping("/changeDealStatus.do")
	public String changeDealStatus(int[] order_seq, String[] deal_status) throws Exception {
		service.changeDealStatus(order_seq, deal_status);
		return "redirect:/order/toOrderList?currentPage=1";
	}

	// 배송 현황 배송 중에서 배송 완료로 변경
	@RequestMapping("/finish_delivery.do")
	public String finish_delivery(int[] order_seq) throws Exception {
		service.finish_delivery(order_seq);
		return "redirect:/order/toOrderList?currentPage=1";
	}

	// 배송 현황 결제완료에서 배송 중으로 변경
	@RequestMapping("/during_delivery.do")
	public String during_delivery(int[] order_seq) throws Exception {
		service.during_delivery(order_seq);
		return "redirect:/order/toOrderList?currentPage=1";
	}

	@RequestMapping("/toSearchList")
	public String toSearchList(String searchOption, String keyword, int currentPage, Model model) throws Exception {
		List<OrderDTO> order_list = service.getSearchList(searchOption, keyword, currentPage);
		ArrayList<ProductDTO> nameList = new ArrayList<>();
		for(int i = 0; i < order_list.size(); i++) {
			ProductDTO dto = productService.selectOne_product(order_list.get(i).getProduct_code());
			nameList.add(dto);
		}
		HashMap<String, Object> naviMap = service.getPageNaviBySearch(searchOption, keyword, currentPage);
		
		model.addAttribute("order_list", order_list);
		model.addAttribute("nameList", nameList);
		model.addAttribute("searchNaviMap", naviMap);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("keyword", keyword);
		return "order_manager/orderList";
	}

}
