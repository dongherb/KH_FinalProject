package ms.com.dto;

public class BuyerInfoDTO {		// 김준형	/ 테이블에는 없는 DTO / 해당상품 구매자의 나이를 출력하는데만 사용
	
	private int age;
	private int count;
	
	public BuyerInfoDTO() {}
	public BuyerInfoDTO(int age, int count) {
		this.age = age;
		this.count = count;
	}
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

}
