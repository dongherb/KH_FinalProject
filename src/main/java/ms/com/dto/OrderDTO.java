package ms.com.dto;

import java.sql.Date;

public class OrderDTO {

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

	public OrderDTO() {
	}

	public OrderDTO(int order_seq, String id, String product_code, String cloth_size, String color, int quantity,
			String deal_status, Date deal_date, int pay_seq, String deliveryAddr, String phone) {
		super();
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

	@Override
	public String toString() {
		return "OrderDTO [order_seq=" + order_seq + ", id=" + id + ", product_code=" + product_code + ", cloth_size="
				+ cloth_size + ", color=" + color + ", quantity=" + quantity + ", deal_status=" + deal_status
				+ ", deal_date=" + deal_date + ", pay_seq=" + pay_seq + ", deliveryAddr=" + deliveryAddr + ", phone="
				+ phone + "]";
	}
}
