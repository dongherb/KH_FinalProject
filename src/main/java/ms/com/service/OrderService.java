package ms.com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.OrderDAO;
import ms.com.dto.OrderDTO;
import ms.com.dto.OrderHistoryDTO;
import ms.com.dto.OrderInfoDTO;

@Service
public class OrderService {

	@Autowired
	OrderDAO dao;
	
	// 장바구니 상태로 주문삽입
	public int insert_unpaidOrder(OrderDTO dto) throws Exception {
		return dao.insert_unpaidOrder(dto);
	}
	
	// 결제완료 상태로 주문삽입
	public int insert_paidOrder(OrderDTO dto_order) throws Exception {
		return dao.insert_paidOrder(dto_order);
	}
	
	public List<OrderDTO> selectAll(String id) throws Exception{
		return dao.selectAll(id);
	}
	
	public OrderDTO selectOne(String id) throws Exception{
		return dao.selectOne(id);
	}
	
	// 수량증가
	public int plusQuantity(int order_seq) throws Exception{
		return dao.plusQuantity(order_seq);
	}
	
	// 수량감소
	public int minusQuantity(int order_seq) throws Exception{
		return dao.minusQuantity(order_seq);
	}
	
	// 수량 입력
	public int inputQuantity(int order_seq, int quantity) throws Exception{
		return dao.inputQuantity(order_seq,quantity);
	}
	
	// 주문 목록 제거
	public int deleteOrder(int order_seq) throws Exception{
		return dao.deleteOrder(order_seq);
	}
	
	// 주문 번호 있는지 확인
	public boolean checkOrder_seq(int order_seq) throws Exception{
		return dao.checkOrder_seq(order_seq);
	}
	
	// 배송 현황 변경
	public int changeDealStatus(int[] order_seq, String[] deal_status) throws Exception {
		return dao.changeDealStatus(order_seq, deal_status);
	}

	// 배송 현황 결제완료에서 배송중으로 변경
	public int during_delivery(int[] order_seq) throws Exception {
		return dao.during_delivery(order_seq);
	}

	// 배송 현황 배송 중에서 배송 완료로 변경
	public int finish_delivery(int[] order_seq) throws Exception {
		return dao.finish_delivery(order_seq);
	}
	
	// 결제 완료 후 거래 상태 변경
	public int updateToPaidByOrder_seq(String deliveryAddr, List<Integer> order_seqList,int pay_seq,String phone) throws Exception{
		return dao.updateToPaidByOrder_seq(deliveryAddr,order_seqList,pay_seq,phone);
	}
	
	// 결제번호로로 해당제품정보, 주문정보, 결제정보 가져오기
	public List<OrderInfoDTO> selectOrderInfoByOrder_seq(int pay_seq) throws Exception {
		return dao.selectOrderInfoByOrder_seq(pay_seq);
	}

	//-------------------- 페이징부분 -------------------------------------------
	// 페이징에 필요한 변수
	private int recordCntPage = 3;	// 하나의 페이지에 보여질 데이터 수
	private int naviCntPage = 5;	// 보여질 네비게이션(페이지) 범위
	
	// 현재 페이지에 대한 안전 장치와 총 페이지 수를 저장하고 있는 메서드 / [0]: 안전장치된 현재페이지, [1]: 총 페이지 수
	private int[] getPageInfromations(String id, String deal_status, int currentPage) throws Exception {

		int recordTototalCnt = dao.getOrderCountByStatus(id, deal_status);	// 해당 카테고리의 전체 데이터의 수
		
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
	public HashMap<String, Object> getPageNavi(String id, String deal_status, int currentPage) throws Exception {

		currentPage = getPageInfromations(id, deal_status, currentPage)[0];	// 현재페이지 안전장치
		int pageTotalCnt = getPageInfromations(id, deal_status, currentPage)[1];	// 총 페이지 수

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
	public List<OrderHistoryDTO> getOrderList(String id, String deal_status, int currentPage) throws Exception{
		
		int recordTototalCnt = dao.getOrderCountByStatus(id, deal_status);	// 해당 조건에 맞는 데이터의 수
		currentPage = getPageInfromations(id, deal_status, currentPage)[0]; 	// 현재페이지로 일어난 오류를 방지

		//----------------------------------------------------------------------------
		
		int startRange = ((currentPage - 1) * recordCntPage) + 1;	// 보여지는 데이터 시작
		int endRange = currentPage * recordCntPage;					// 보여지는 데이터 끝
		if(endRange >= recordTototalCnt) {	// 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<OrderHistoryDTO> list = dao.selectOrderByStatus(id, deal_status, startRange, endRange);	// 범위에있는 값을 list로 가져옴
		return list;
	}
	//--------------------------------------------------------
	
	// 해당상태의 주문의 개수를 카운트함
	public int getOrderCountByStatus(String id, String deal_status) throws Exception {
		return dao.getOrderCountByStatus(id, deal_status);
	}

	// 해당주문의 상태를 변경함
	public int updateStatus_order(int order_seq, String deal_status) throws Exception {
		return dao.updateStatus_order(order_seq, deal_status);
	}
	
	// --------------------------------------------------------
	// 관리자 주문 내역 부분

	private int managerRecordCntPage = 10; // 관리자 페이지에서 하나의 페이지에 보여질 데이터 수
	private int managerNaviCntPage = 5; // 관리자 페이지 네비게이션 바 개수

	// 주문 내역 전체 리스트 불러오기
	public List<OrderDTO> managerOrderList(int currentPage) throws Exception {
		int recordTototalCnt = dao.getManagerOrderCount(); // 해당 조건에 맞는 데이터의 수
		currentPage = getManagerPageInfromations(currentPage)[0]; // 현재페이지로 일어난 오류를 방지

		// ----------------------------------------------------------------------------

		int startRange = ((currentPage - 1) * managerRecordCntPage) + 1; // 보여지는 데이터 시작
		int endRange = currentPage * managerRecordCntPage; // 보여지는 데이터 끝
		if (endRange >= recordTototalCnt) { // 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<OrderDTO> list = dao.managerOrderList(startRange, endRange); // 범위에있는 값을 list로 가져옴
		return list;
	}

	private int[] getManagerPageInfromations(int currentPage) throws Exception {

		int recordTototalCnt = dao.getManagerOrderCount(); // 해당 카테고리의 전체 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % managerRecordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / managerRecordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / managerRecordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	public HashMap<String, Object> getManagerPageNavi(int currentPage) throws Exception {

		currentPage = getManagerPageInfromations(currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getManagerPageInfromations(currentPage)[1]; // 총 페이지 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / managerNaviCntPage) * managerNaviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (managerNaviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
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

	// 검색시 불러올 주문 List
	public List<OrderDTO> getSearchList(String searchOption, String keyword, int currentPage) throws Exception {
		int recordTototalCnt = dao.getOrderCountBySearch(searchOption, keyword);
		currentPage = getSearchPageInfromations(searchOption, keyword, currentPage)[0];

		int startRange = ((currentPage - 1) * managerRecordCntPage) + 1;
		int endRange = currentPage * managerRecordCntPage;
		if (endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}

		List<OrderDTO> list = dao.selectOrderBySearch(searchOption, keyword, startRange, endRange);
		return list;
	}

	// 검색 시 사용 메서드
	private int[] getSearchPageInfromations(String searchOption, String keyword, int currentPage) throws Exception {

		int recordTototalCnt = dao.getOrderCountBySearch(searchOption, keyword); // 해당 카테고리의 전체 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % managerRecordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / managerRecordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / managerRecordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	public HashMap<String, Object> getPageNaviBySearch(String searchOption, String keyword, int currentPage)
			throws Exception {

		currentPage = getSearchPageInfromations(searchOption, keyword, currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getSearchPageInfromations(searchOption, keyword, currentPage)[1]; // 총 페이지 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / managerNaviCntPage) * managerNaviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (managerNaviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
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
	
	// 장바구니 상태인 주문들 삭제
	public int deleteOrderInBasket(String product_code) {
		return dao.deleteOrderInBasket(product_code);
	}

}
