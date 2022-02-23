package ms.com.dto;

public class AdvertisementDTO {
	public AdvertisementDTO() {}
	
	private String weather;
	private String product_code;
	private String product_img;
	
	public AdvertisementDTO(String weather, String product_code, String product_img) {
		super();
		this.weather = weather;
		this.product_code = product_code;
		this.product_img = product_img;
	}

	@Override
	public String toString() {
		return "AdvertisementDTO [weather=" + weather + ", product_code=" + product_code + ", product_img="
				+ product_img + "]";
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather(String weather) {
		this.weather = weather;
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
	
}
