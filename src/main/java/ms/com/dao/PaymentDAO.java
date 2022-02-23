package ms.com.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.PaymentDTO;

@Repository
public class PaymentDAO {
	@Autowired
	private SqlSession session;
	
	// 결제 테이블에 입력
	public int insert(PaymentDTO dto) throws Exception{
		return session.insert("paymentMapper.insert",dto);
	}
	
	// pay_seq 받아오기
	public int getPaySeq() throws Exception{
		return session.selectOne("paymentMapper.getPaySeq");
	}
}
