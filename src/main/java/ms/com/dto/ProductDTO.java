package ms.com.dto;

public class ProductDTO {
	public ProductDTO() {}
	
	private String product_code;
	private String product_name;
	private String product_content;
	private String product_category;
	private String detail_category;
	private int price;
	private int discount;
	private float avg_score;
	private String product_img;
	private String detail_img;
	private int review_count;
	
	public ProductDTO(String product_code, String product_name, String product_content, String product_category,
			String detail_category, int price, int discount, float avg_score, String product_img, String detail_img,
			int review_count) {
		this.product_code = product_code;
		this.product_name = product_name;
		this.product_content = product_content;
		this.product_category = product_category;
		this.detail_category = detail_category;
		this.price = price;
		this.discount = discount;
		this.avg_score = avg_score;
		this.product_img = product_img;
		this.detail_img = detail_img;
		this.review_count = review_count;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
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

	public String getDetail_img() {
		return detail_img;
	}

	public void setDetail_img(String detail_img) {
		this.detail_img = detail_img;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	
}
