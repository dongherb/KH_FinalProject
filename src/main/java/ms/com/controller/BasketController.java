package ms.com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.MemberDTO;
import ms.com.dto.OrderDTO;
import ms.com.dto.ProductDTO;
import ms.com.service.OrderService;
import ms.com.service.ProductService;

@Controller
@RequestMapping("/order")
public class BasketController {

	@Autowired
	HttpSession session;
	@Autowired
	OrderService orderService;
	@Autowired
	ProductService productService;
	
	@RequestMapping(value="/toBasket")
	public String toPay(Model model) throws Exception{

		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String id = dto_mem.getId();
		
		List<OrderDTO> list = orderService.selectAll(id);
		//System.out.println("리스트 : " + list);
		List<String> product_codes = new ArrayList<>(); 
		
		if(!list.isEmpty()) {
			System.out.println("실행됨");
			for (OrderDTO orderDTO : list) {
				product_codes.add(orderDTO.getProduct_code());
			}
			// 제품코드 리스트(product_codes)를 가져다가 제품코드에 맞는 정보들을 반환함
			List<ProductDTO> product_list = productService.selectByProductCode(product_codes);
			model.addAttribute("product_list",product_list);
		}
		
		model.addAttribute("list",list);
		return "mypage/basket";
	}
	
	// 버튼 눌러서 수량 증가
	@RequestMapping(value="/plusQuantity")
	public String plusQuantity(int order_seq) throws Exception{

		orderService.plusQuantity(order_seq);
		return "redirect:/order/toBasket";
	} 
	
	// 버튼 눌러서 수량 감소
	@RequestMapping(value="/minusQuantity")
	public String minusQuantity(int order_seq) throws Exception{
		
		orderService.minusQuantity(order_seq);
		return "redirect:/order/toBasket";
	}
	
	// 수량 입력
	@RequestMapping(value="/inputQuantity")
	public String inputQuantity(int order_seq,int quantity) throws Exception{
		orderService.inputQuantity(order_seq,quantity);
		return "redirect:/order/toBasket";
	}
	
	// 주문 목록 제거
	@RequestMapping(value="/deleteOrder")
	public String deleteOrder(int order_seq) throws Exception{
		orderService.deleteOrder(order_seq);
		System.out.println("주문 목록 제거 확인" + order_seq);
		return "redirect:/order/toBasket";
	}
	
}
