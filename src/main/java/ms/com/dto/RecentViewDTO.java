package ms.com.dto;

import java.sql.Date;

public class RecentViewDTO {

	private String id;
	private String product_code;
	private String product_img;
	private Date view_date;
	
	public RecentViewDTO() {}
	public RecentViewDTO(String id, String product_code, String product_img, Date view_date) {
		this.id = id;
		this.product_code = product_code;
		this.product_img = product_img;
		this.view_date = view_date;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public Date getView_date() {
		return view_date;
	}
	public void setView_date(Date view_date) {
		this.view_date = view_date;
	}

}
