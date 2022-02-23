package ms.com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ms.com.dto.MemberDTO;
import ms.com.dto.OrderDTO;
import ms.com.dto.PaymentDTO;
import ms.com.service.MemberService;
import ms.com.service.OrderService;
import ms.com.service.PaymentService;

@Controller
@RequestMapping("/pay")
public class PaymentController {
	
	@Autowired
	HttpSession session;
	@Autowired
	PaymentService service;
	@Autowired
	OrderService orderService;
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/paySuccess")
	@ResponseBody
	public String paySuccess(int use_point,String pay_type,String pg_type, int origin_price, int real_price,String card_name,int card_code,String deliveryAddr,String phone) throws Exception{

		MemberDTO dto_mem = (MemberDTO) session.getAttribute("loginSession");
		String id = dto_mem.getId();
		
		// pay_seq 받아오기
		int pay_seq = service.getPaySeq();
		
		// 1. tempOrderDTO가 비어있을경우 / 바로구매하기를 누른것이 아닐경우 (장바구니로 결제함)
		if(session.getAttribute("tempOrderDTO") == null) {	
			
			List<OrderDTO> list = orderService.selectAll(id);
			List<Integer> order_seqList = new ArrayList<>();
			for (OrderDTO dto : list) {
				order_seqList.add(dto.getOrder_seq());
			}

			// 결제 완료 상태로 바꾸기 위한 메서드
			orderService.updateToPaidByOrder_seq(deliveryAddr, order_seqList,pay_seq,phone);
		}
		
		// 2. 바로 구매하기 버튼를 클릭해서 결제한경우
		else {
			
			OrderDTO dto_order = (OrderDTO) session.getAttribute("tempOrderDTO");	// 임시로 세션에 담아놓았던 tempOrderDTO를 가져옴
			dto_order.setId(id);
			dto_order.setPay_seq(pay_seq);
			dto_order.setDeliveryAddr(deliveryAddr);
			dto_order.setPhone(phone);

			// 처음부터 결제완료상태로 새 주문을 생성
			orderService.insert_paidOrder(dto_order);
			
			session.removeAttribute("tempOrderDTO");	// 임시 세션 tempOrderDTO 주문정보 삭제
		}

		// 결제 정보 삽입하기 위한 메서드
		PaymentDTO dto = new PaymentDTO(0,use_point,pay_type,pg_type,origin_price,real_price,null,card_name,card_code);
		dto.setPay_seq(pay_seq);
		service.insert(dto);
		
		// 결제 완료 후 잔여 포인트 업데이트 해주는 메서드
		if(use_point == 0) {
			int addPoint = Math.round((origin_price-2500) / 2);
			memberService.updatePoint_member(id,addPoint);
			MemberDTO dto_member = memberService.getMember(id);
			session.setAttribute("loginSession",dto_member);
		}else if (use_point != 0) {
			memberService.descPoint_member(id, use_point);
			MemberDTO dto_member = memberService.getMember(id);
			session.setAttribute("loginSession",dto_member);
		}
		return "success";
	}
	
	// 결제 성공 시 이동하는 페이지
	@RequestMapping(value="/Success")
	public String success() {
		return "/payment/Success";
	}
}
	

