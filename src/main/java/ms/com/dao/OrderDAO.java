package ms.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.OrderDTO;
import ms.com.dto.OrderHistoryDTO;
import ms.com.dto.OrderInfoDTO;

@Repository
public class OrderDAO {

	@Autowired
	SqlSession session;
	
	//----- 페이징 관련 -------------
	// 사용자의 주문기록 데이터 수 가져오기 / 상태별 (장바구니 제외)
	public int getOrderCountByStatus(String id, String deal_status) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("deal_status", deal_status);
		
		return session.selectOne("orderMapper.getOrderCountByStatus", map);
	}
	
	// 사용자 주문기록중 해당 범위안의 데이터만 리스트로 가져오기	/ 상태별 (장바구니 제외)
	public List<OrderHistoryDTO> selectOrderByStatus(String id, String deal_status, int startRange, int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("deal_status", deal_status);
		map.put("startRange", startRange);
		map.put("endRange", endRange);
		
		return session.selectList("orderMapper.selectOrderByStatus", map);
	}
	// ------------------------------

	// 결제되지않은 주문삽입
	public int insert_unpaidOrder(OrderDTO dto) throws Exception {
		return session.insert("orderMapper.insert_unpaidOrder", dto);
	}
	
	// 결제된상태로 주문삽입
	public int insert_paidOrder(OrderDTO dto_order) {
		return session.insert("orderMapper.insert_paidOrder", dto_order);
	}
	
	public List<OrderDTO> selectAll(String id) throws Exception{
		return session.selectList("orderMapper.selectAll",id);
	}
	
	public OrderDTO selectOne(String id) throws Exception{
		return session.selectOne("orderMapper.selectOne",id);
	}
	
	// 수량 증가
	public int plusQuantity(int order_seq) throws Exception{
		return session.update("orderMapper.plusQuantity", order_seq);
	}
	
	// 수량 감소
	public int minusQuantity(int order_seq) throws Exception{
		return session.update("orderMapper.minusQuantity", order_seq);
	}
	
	// 수량 입력
	public int inputQuantity(int order_seq, int quantity) throws Exception{
		Map<String,Integer> map = new HashMap<>(); 
		map.put("order_seq", order_seq);
		map.put("quantity", quantity);
		
		return session.update("orderMapper.inputQuantity",map);
	}
	
	// 주문 목록 제거
	public int deleteOrder(int order_seq) throws Exception{
		return session.delete("orderMapper.deleteOrder", order_seq);
	}
	
	// 주문 번호 있는지 확인
	public boolean checkOrder_seq(int order_seq) throws Exception{
		return session.selectOne("orderMapper.checkOrder_seq", order_seq);
	}
	
	// 결제 완료 후 거래 상태 변경
	public int updateToPaidByOrder_seq(String deliveryAddr,List<Integer> order_seqList,int pay_seq,String phone) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("deliveryAddr", deliveryAddr);
		map.put("order_seqList", order_seqList);
		map.put("pay_seq", pay_seq);
		map.put("phone", phone);
		return session.update("orderMapper.updateToPaidByOrder_seq",map);
	}
	
	// 해당주문의 상태를 변경함
	public int updateStatus_order(int order_seq, String deal_status) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("order_seq", order_seq);
		map.put("deal_status", deal_status);
		
		return session.update("orderMapper.updateStatus_order", map);
	}
	
	// 결제번호로로 해당제품정보, 주문정보, 결제정보 가져오기
	public List<OrderInfoDTO> selectOrderInfoByOrder_seq (int pay_seq) throws Exception {
		return session.selectList("orderMapper.selectOrderInfoByPay_seq", pay_seq);
	}
	
	// 관리자 관련 부문 --------------------------------------------------
	// 관리자 페이지 주문 총 목록 불러오기
	public List<OrderDTO> managerOrderList(int startRange, int endRange) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		return session.selectList("orderMapper.managerOrderList", map);
	}

	// 주문 총 목록 갯수
	public int getManagerOrderCount() throws Exception {
		return session.selectOne("orderMapper.getManagerOrderCount");
	}

	// 배송 현황 변경
	public int changeDealStatus(int[] order_seq, String[] deal_status) throws Exception {
		Map<String, Object> map = new HashMap<>();

		for (int i = 0; i < order_seq.length; i++) {
			map.put("order_seq", order_seq[i]);
			map.put("deal_status", deal_status[i]);
			session.update("orderMapper.updateStatus_order", map);
		}

		return 1;
	}

	// 배송 현황 결제완료에서 배송중으로 변경
	public int during_delivery(int[] order_seq) throws Exception {
		Map<String, Object> map = new HashMap<>();

		for (int i = 0; i < order_seq.length; i++) {
			map.put("order_seq", order_seq[i]);
			map.put("deal_status", "배송중");
			session.update("orderMapper.updateStatus_order", map);
		}

		return 1;
	}

	// 배송 현황 배송 중에서 배송 완료로 변경
	public int finish_delivery(int[] order_seq) throws Exception {
		Map<String, Object> map = new HashMap<>();

		for (int i = 0; i < order_seq.length; i++) {
			map.put("order_seq", order_seq[i]);
			map.put("deal_status", "배송완료");
			session.update("orderMapper.updateStatus_order", map);
		}

		return 1;
	}

	// 검색한 제품들 총 데이터 수 반환
	public int getOrderCountBySearch(String searchOption, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);

		return session.selectOne("orderMapper.getOrderCountBySearch", map);
	}

	// 검색한 범위 안의 데이터 리스트 반환
	public List<OrderDTO> selectOrderBySearch(String searchOption, String keyword, int startRange, int endRange)
			throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("startRange", startRange);
		map.put("endRange", endRange);

		return session.selectList("orderMapper.selectOrderBySearch", map);
	}

	// 장바구니 상태인 주문들 삭제
	public int deleteOrderInBasket(String product_code) {
		return session.delete("orderMapper.deleteOrderInBasket", product_code);
	}
}
