package ms.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.PaymentDAO;
import ms.com.dto.PaymentDTO;

@Service
public class PaymentService {
	@Autowired
	PaymentDAO dao;
	
	// 결제 테이블에 입력
	public int insert(PaymentDTO dto) throws Exception{
		return dao.insert(dto);
	}
	
	// 결제번호가져오기
	public int getPaySeq() throws Exception{
		return dao.getPaySeq();
	}
}
