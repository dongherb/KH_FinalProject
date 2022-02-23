package ms.com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.EnquiryCommentDTO;
import ms.com.dto.EnquiryDTO;
import ms.com.dto.MemberDTO;
import ms.com.dto.NoticeDTO;

@Repository
public class EnquiryDAO {
	@Autowired
	private SqlSession session;

	//게시글 전체 가져오기(회원용)
	public List<EnquiryDTO> selectMyRegister(String member_id) throws Exception {
		return session.selectList("enquiryMapper.selectMyRegister", member_id);
	}

	// 게시글 하나 가져오기
	public EnquiryDTO selectOne(int enquiry_seq) throws Exception {
		return session.selectOne("enquiryMapper.selectOne", enquiry_seq);
	}

	// 게시글 등록
	public int insertEnquiry(EnquiryDTO dto) throws Exception {
		return session.insert("enquiryMapper.insertEnquiry", dto);
	}
	
	//게시글 삭제
	public int deleteEnquiry(int enquiry_seq) throws Exception{
		return session.delete("enquiryMapper.deleteEnquiry", enquiry_seq);
	}
	
	//게시글 수정
	public int modifyEnquiry(EnquiryDTO dto) throws Exception{
		return session.update("enquiryMapper.modifyEnquiry", dto);
	}
	
	// 게시글 전체 가져오기(관리자용)
	public List<EnquiryDTO> selectAll() throws Exception {
		return session.selectList("enquiryMapper.selectAll");
	}
	
	//관리자 답변댓글 등록(관리자용)
	public int updateEnquiryComment(EnquiryDTO dto) throws Exception {
		System.out.println("DAO 댓글등록 : " + dto);
		return session.update("enquiryMapper.updateEnquiryComment", dto);
	}
	
	//관리자 답변댓글 가져오기(관리자용)
	public EnquiryDTO getEnquiryComment(int enquiry_seq) throws Exception{
		return session.selectOne("enquiryMapper.getEnquiryComment", enquiry_seq);
	}
		
	//관리자 답변댓글 삭제(관리자용)
	public int deleteEnquiryCmt(int enquiry_seq) throws Exception {
		return session.update("enquiryMapper.deleteEnquiryCmt", enquiry_seq);
	}

	//관리자 답변댓글 수정(관리자용)
	public int enquiryModifyCmt(EnquiryDTO dto) {
		return session.update("enquiryMapper.enquiryModifyCmt", dto);
	}
	
}
