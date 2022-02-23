package ms.com.dto;

import java.sql.Date;

public class OrderHistoryDTO {	// 김준형	// 주문내역을 출력하는데에만 활용될 DTO 	/ 테이블에는 없는 DTO

	private int order_seq;
	private String id;
	private String product_code;
	private String cloth_size;
	private String color;
	private int quantity;
	private String deal_status;		// 주문상태 (장바구니, 결제완료, 배송중, 배송완료, 구매확정, 리뷰완료)
	private Date deal_date;			
	private int pay_seq;
	private String deliveryAddr;
	
	private String product_name;		// join으로 가져오기
	private String product_category;
	private String detail_category;
	private int price;
	private int discount;
	private String product_img;
	
	
	public OrderHistoryDTO() {}
	public OrderHistoryDTO(int order_seq, String id, String product_code, String cloth_size, String color, int quantity,
			String deal_status, Date deal_date, int pay_seq, String deliveryAddr, String product_name,
			String product_category, String detail_category, int price, int discount, String product_img) {
		this.order_seq = order_seq;
		this.id = id;
		this.product_code = product_code;
		this.cloth_size = cloth_size;
		this.color = color;
		this.quantity = quantity;
		this.deal_status = deal_status;
		this.deal_date = deal_date;
		this.pay_seq = pay_seq;
		this.deliveryAddr = deliveryAddr;
		this.product_name = product_name;
		this.product_category = product_category;
		this.detail_category = detail_category;
		this.price = price;
		this.discount = discount;
		this.product_img = product_img;
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
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getCloth_size() {
		return cloth_size;
	}
	public void setCloth_size(String cloth_size) {
		this.cloth_size = cloth_size;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDeal_status() {
		return deal_status;
	}
	public void setDeal_status(String deal_status) {
		this.deal_status = deal_status;
	}
	public Date getDeal_date() {
		return deal_date;
	}
	public void setDeal_date(Date deal_date) {
		this.deal_date = deal_date;
	}
	public int getPay_seq() {
		return pay_seq;
	}
	public void setPay_seq(int pay_seq) {
		this.pay_seq = pay_seq;
	}
	public String getDeliveryAddr() {
		return deliveryAddr;
	}
	public void setDeliveryAddr(String deliveryAddr) {
		this.deliveryAddr = deliveryAddr;
	}
	
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	public String getDetail_category() {
		return detail_category;
	}
	public void setDetail_category(String detail_category) {
		this.detail_category = detail_category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

}
