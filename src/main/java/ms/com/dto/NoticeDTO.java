package ms.com.dto;

import java.sql.Date;

public class NoticeDTO {
	public NoticeDTO() {}
	
	private int notice_seq;
	private String title;
	private String content;
	private String notice_img;
	private Date written_date;
	
	public NoticeDTO(int notice_seq, String title, String content, String notice_img, Date written_date) {
		super();
		this.notice_seq = notice_seq;
		this.title = title;
		this.content = content;
		this.notice_img = notice_img;
		this.written_date = written_date;
	}

	@Override
	public String toString() {
		return "NoticeDTO [notice_seq=" + notice_seq + ", title=" + title + ", content=" + content + ", notice_img="
				+ notice_img + ", written_date=" + written_date + "]";
	}

	public int getNotice_seq() {
		return notice_seq;
	}

	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
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

	public String getNotice_img() {
		return notice_img;
	}

	public void setNotice_img(String notice_img) {
		this.notice_img = notice_img;
	}

	public Date getWritten_date() {
		return written_date;
	}

	public void setWritten_date(Date written_date) {
		this.written_date = written_date;
	}
	
}
