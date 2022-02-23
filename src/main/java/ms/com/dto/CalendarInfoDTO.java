package ms.com.dto;

public class CalendarInfoDTO {		// 김준형	/ 테이블에는 없는 DTO	/ 달력에 대한 정보를 출력하는데 활용
	private String year;
	private String month;
	private int firstDay;	// 1: 일요일 ~ 7: 토요일
	private int numberOfDays;
	
	public CalendarInfoDTO() {}
	public CalendarInfoDTO(String year, String month, int firstDay, int numberOfDays) {
		this.year = year;
		this.month = month;
		this.firstDay = firstDay;
		this.numberOfDays = numberOfDays;
	}
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getFirstDay() {
		return firstDay;
	}
	public void setFirstDay(int firstDay) {
		this.firstDay = firstDay;
	}
	public int getNumberOfDays() {
		return numberOfDays;
	}
	public void setNumberOfDays(int numberOfDays) {
		this.numberOfDays = numberOfDays;
	};
}
