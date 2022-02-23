package ms.com.dto;

import java.sql.Date;

public class ReviewDTO {
	
	private int review_seq;
	private String product_code;
	private int order_seq;
	private String id;
	private String content;
	private int height;
	private int weight;
	private float score;
	private Date written_date;
	private String review_img;
	
	public ReviewDTO() {}
	public ReviewDTO(int review_seq, String product_code, int order_seq, String id, String content, int height,
			int weight, float score, Date written_date, String review_img) {
		this.review_seq = review_seq;
		this.product_code = product_code;
		this.order_seq = order_seq;
		this.id = id;
		this.content = content;
		this.height = height;
		this.weight = weight;
		this.score = score;
		this.written_date = written_date;
		this.review_img = review_img;
	}
	
	public int getReview_seq() {
		return review_seq;
	}
	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	public Date getWritten_date() {
		return written_date;
	}
	public void setWritten_date(Date written_date) {
		this.written_date = written_date;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}
}
