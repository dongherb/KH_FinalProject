package ms.com.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ms.com.dto.MemberDTO;
import ms.com.dto.OrderDTO;
import ms.com.dto.OrderHistoryDTO;
import ms.com.dto.OrderInfoDTO;
import ms.com.service.OrderService;


@Controller
@RequestMapping(value = "/mypageOrder")
public class MyPageOrderHistoryController {

	@Autowired
	private HttpSession session;
	@Autowired
	private OrderService service;
	
	// 주문내역조회 페이지로
	@RequestMapping(value = "/toMyOrderHistory")
	public String toMyOrderHistory(String deal_status, int currentPage, Model model) throws Exception {

		// deal_status 처리
		if( deal_status.equals("") || (deal_status == null) ) {	// 빈값이거나, null일 경우 / 전체로 변경
			deal_status = "전체";
		}
		
		MemberDTO dto_mem = (MemberDTO)(session.getAttribute("loginSession"));
		String id = dto_mem.getId();
		
		List<OrderHistoryDTO> list = service.getOrderList(id, deal_status, currentPage);
		HashMap<String, Object> naviMap = service.getPageNavi(id, deal_status, currentPage);
		
		// 전체, 결제완료, 배송중, 배송완료, 구매확정 상태의 각 개수를 가져옴
		int status_all = service.getOrderCountByStatus(id, "전체");
		int status_1 = service.getOrderCountByStatus(id, "결제완료");
		int status_2 = service.getOrderCountByStatus(id, "배송중");
		int status_3 = service.getOrderCountByStatus(id, "배송완료");
		int status_4 = service.getOrderCountByStatus(id, "구매확정");
		int[] statusCounts = {status_all, status_1, status_2, status_3, status_4};

		model.addAttribute("naviMap", naviMap);
		model.addAttribute("orderList", list);
		model.addAttribute("deal_status", deal_status);
		model.addAttribute("statusCounts", statusCounts);

		
		return "/mypage/myOrderHistory";
	}
	
	// 주문을 구매확정으로 변경하기
	@RequestMapping(value = "/changeToDecideProc")
	public String changeToDecideProc(int order_seq, Model model) throws Exception {
		
		String deal_status = "구매확정";
		int rs = service.updateStatus_order(order_seq, deal_status);
		
		if(rs == 1) {	// 수정성공
			model.addAttribute("done", "done");
		}
		else {
			model.addAttribute("done", "fail");
		}
		
		model.addAttribute("deal_status", deal_status);
		model.addAttribute("currentPage", 1);
		
		return "redirect:/mypageOrder/toMyOrderHistory";
	}
	
	// 결제정보보기클릭 시 결제정보 팝업창 띄움
	@RequestMapping(value = "/toShowPaymentPapup")
	public String toShowPaymentPapup(int pay_seq, Model model) throws Exception {
		
		List<OrderInfoDTO> list = service.selectOrderInfoByOrder_seq(pay_seq);
		
		if(!list.isEmpty()) {	// 결제정보가 비어있지 않을 시
			model.addAttribute("orderInfoList", list);
		}
		else {	// 결제 정보가 없을 시 / 오류방지
			model.addAttribute("done","fail");
		}
		
		return "mypage/showPaymentPapup";
	}
}
