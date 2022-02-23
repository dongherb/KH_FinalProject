package ms.com.service;

import java.io.File;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.EnquiryDAO;
import ms.com.dto.EnquiryCommentDTO;
import ms.com.dto.EnquiryDTO;

@Service
public class EnquiryService {
	@Autowired
	private EnquiryDAO enquiryDao;
	
	// 게시글 하나 가져오기
	public EnquiryDTO selectOne(int enquiry_seq) throws Exception {
		return enquiryDao.selectOne(enquiry_seq);
	}
	
	//게시글 작성
	public int insertEnquiry(EnquiryDTO dto) throws Exception {
//		int enquiry_seq = enquiryDao.selectSeq();		
//		System.out.println("enquiry_seq" + ":" + enquiry_seq);
//		dto.setEnquiry_seq(enquiry_seq);
		return enquiryDao.insertEnquiry(dto);
	}
	
	//게시글 삭제
	public int deleteEnquiry(int enquiry_seq) throws Exception{
		return enquiryDao.deleteEnquiry(enquiry_seq);
	}
	
	//게시글 수정
	public int modifyEnquiry(EnquiryDTO dto) throws Exception{
		return enquiryDao.modifyEnquiry(dto);
	}

	//게시글 리스트 가져오기(회원용)
	public List<EnquiryDTO> selectMyRegister(String member_id) throws Exception {
		return enquiryDao.selectMyRegister(member_id);
	}
	
	// 게시글 리스트 가져오기(관리자용)
	public List<EnquiryDTO> selectAll() throws Exception {
		return enquiryDao.selectAll();
	}
	
	//관리자 답변댓글 등록
	public int updateEnquiryComment(EnquiryDTO dto) throws Exception {
		return enquiryDao.updateEnquiryComment(dto);
	}
	
	//관리자 답변댓글 가져오기
	public EnquiryDTO getEnquiryComment(int enquiry_seq) throws Exception {
		return enquiryDao.getEnquiryComment(enquiry_seq);	
	}
	
	//관리자 답변댓글 삭제
	public int deleteEnquiryCmt(int enquiry_seq) throws Exception {
		return enquiryDao.deleteEnquiryCmt(enquiry_seq);
	}
	
	//관리자 답변댓글 수정
	public int enquiryModifyCmt(EnquiryDTO dto) throws Exception{
		return enquiryDao.enquiryModifyCmt(dto);
	}
	
	
}
