package ms.com.dto;

import java.sql.Date;

public class EnquiryCommentDTO {
	private int comment_seq;
	private String answer_id;
	private String answer;
	private Date answer_date;
	private Date enquiry_seq;
	
	public EnquiryCommentDTO() {}

	public EnquiryCommentDTO(int comment_seq, String answer_id, String answer, Date answer_date, Date enquiry_seq) {
		super();
		this.comment_seq = comment_seq;
		this.answer_id = answer_id;
		this.answer = answer;
		this.answer_date = answer_date;
		this.enquiry_seq = enquiry_seq;
	}

	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}

	public String getAnswer_id() {
		return answer_id;
	}

	public void setAnswer_id(String answer_id) {
		this.answer_id = answer_id;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Date getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}

	public Date getEnquiry_seq() {
		return enquiry_seq;
	}

	public void setEnquiry_seq(Date enquiry_seq) {
		this.enquiry_seq = enquiry_seq;
	}

	
}
