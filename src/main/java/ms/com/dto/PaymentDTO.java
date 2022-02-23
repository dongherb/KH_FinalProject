package ms.com.dto;

import java.sql.Date;

public class PaymentDTO {
	
	private int pay_seq;
	private int use_point;
	private String pay_type;
	private String pg_type;
	private int origin_price;
	private int real_price;
	private Date pay_date;
	private String card_name;
	private int card_code;

	public PaymentDTO() {
	}

	public PaymentDTO(int pay_seq, int use_point, String pay_type, String pg_type, int origin_price, int real_price,
			Date pay_date, String card_name, int card_code) {
		super();
		this.pay_seq = pay_seq;
		this.use_point = use_point;
		this.pay_type = pay_type;
		this.pg_type = pg_type;
		this.origin_price = origin_price;
		this.real_price = real_price;
		this.pay_date = pay_date;
		this.card_name = card_name;
		this.card_code = card_code;
	}

	public int getPay_seq() {
		return pay_seq;
	}

	public void setPay_seq(int pay_seq) {
		this.pay_seq = pay_seq;
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

	@Override
	public String toString() {
		return "PaymentDTO [pay_seq=" + pay_seq + ", use_point=" + use_point + ", pay_type=" + pay_type + ", pg_type="
				+ pg_type + ", origin_price=" + origin_price + ", real_price=" + real_price + ", pay_date=" + pay_date
				+ ", card_name=" + card_name + ", card_code=" + card_code + "]";
	}

}
