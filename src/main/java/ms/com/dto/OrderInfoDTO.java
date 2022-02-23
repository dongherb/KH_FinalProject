package ms.com.dto;

import java.sql.Date;

public class OrderInfoDTO {

	private int order_seq;
	private String id;
	private String product_code;
	private String cloth_size;
	private String color;
	private int quantity;
	private String deal_status; // 주문상태 (장바구니, 결제완료, 배송중, 배송완료, 구매확정, 리뷰완료)
	private Date deal_date;
	private int pay_seq;
	private String deliveryAddr;
	private String phone;
	
	private String product_name;
	private String product_category;
	private String detail_category;
	private float avg_score;
	private String product_img;
	private int review_count;
	
	private int use_point;
	private String pay_type;
	private String pg_type;
	private int origin_price;
	private int real_price;
	private Date pay_date;
	private String card_name;
	private int card_code;
	
	public OrderInfoDTO() {}

	public OrderInfoDTO(int order_seq, String id, String product_code, String cloth_size, String color, int quantity,
			String deal_status, Date deal_date, int pay_seq, String deliveryAddr, String phone, String product_name,
			String product_category, String detail_category, float avg_score, String product_img, int review_count,
			int use_point, String pay_type, String pg_type, int origin_price, int real_price, Date pay_date,
			String card_name, int card_code) {
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
		this.phone = phone;
		this.product_name = product_name;
		this.product_category = product_category;
		this.detail_category = detail_category;
		this.avg_score = avg_score;
		this.product_img = product_img;
		this.review_count = review_count;
		this.use_point = use_point;
		this.pay_type = pay_type;
		this.pg_type = pg_type;
		this.origin_price = origin_price;
		this.real_price = real_price;
		this.pay_date = pay_date;
		this.card_name = card_name;
		this.card_code = card_code;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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

	public float getAvg_score() {
		return avg_score;
	}

	public void setAvg_score(float avg_score) {
		this.avg_score = avg_score;
	}

	public String getProduct_img() {
		return product_img;
	}

	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public int getUse_point() {
		return use_point;
	}

	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}

	public String getPay_type() {
		return pay_type;
	}

	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}

	public String getPg_type() {
		return pg_type;
	}

	public void setPg_type(String pg_type) {
		this.pg_type = pg_type;
	}

	public int getOrigin_price() {
		return origin_price;
	}

	public void setOrigin_price(int origin_price) {
		this.origin_price = origin_price;
	}

	public int getReal_price() {
		return real_price;
	}

	public void setReal_price(int real_price) {
		this.real_price = real_price;
	}

	public Date getPay_date() {
		return pay_date;
	}

	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public int getCard_code() {
		return card_code;
	}

	public void setCard_code(int card_code) {
		this.card_code = card_code;
	}
	
	
}
