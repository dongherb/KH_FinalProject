package ms.com.dto;

public class ReportDTO {
	public ReportDTO() {}
	
	private int report_seq;
	private String id;
	private int review_seq;
	private String category;
	private String reason;
	
	public ReportDTO(int report_seq, String id, int review_seq, String category, String reason) {
		super();
		this.report_seq = report_seq;
		this.id = id;
		this.review_seq = review_seq;
		this.category = category;
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "ReportDTO [report_seq=" + report_seq + ", id=" + id + ", review_seq=" + review_seq + ", category="
				+ category + ", reason=" + reason + "]";
	}

	public int getReport_seq() {
		return report_seq;
	}

	public void setReport_seq(int report_seq) {
		this.report_seq = report_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getReview_seq() {
		return review_seq;
	}

	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
}
