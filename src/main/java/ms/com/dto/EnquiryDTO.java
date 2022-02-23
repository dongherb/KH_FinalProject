package ms.com.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class EnquiryDTO {
	private int enquiry_seq; 
	private String id;
	private String title;
	private String content;
	private String category;
	private String answer;
	private String enquiry_date;
	private String answer_date;
	
	public EnquiryDTO () {}

	public EnquiryDTO(int enquiry_seq, String id, String title, String content, String category, String answer,
			String enquiry_date, String answer_date) {
		super();
		this.enquiry_seq = enquiry_seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.category = category;
		this.answer = answer;
		this.enquiry_date = enquiry_date;
		this.answer_date = answer_date;
	}

	public int getEnquiry_seq() {
		return enquiry_seq;
	}

	public void setEnquiry_seq(int enquiry_seq) {
		this.enquiry_seq = enquiry_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getEnquiry_date() {
		return enquiry_date;
	}

	public void setEnquiry_date(Date enquiry_date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		this.enquiry_date = sdf.format(enquiry_date);
	}

	public String getAnswer_date() {
		return answer_date;
	}
	
	public void setAnswer_date(Date answer_date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		this.answer_date = sdf.format(answer_date);
	}

	@Override
	public String toString() {
		return "EnquiryDTO [enquiry_seq=" + enquiry_seq + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", category=" + category + ", answer=" + answer + ", enquiry_date=" + enquiry_date + ", answer_date="
				+ answer_date + "]";
	}

}
