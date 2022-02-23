package ms.com.dto;

import java.sql.Date;

public class MemberDTO {
	public MemberDTO() {}
	
	private String id;
	private String pw;
	private String name;
	private String phone;
	private String address;
	private int birth_date;
	private Date signup_date;
	private int total_point;
	private int extra_point;
	private String manager_yn;
	private int height;
	private int weight;
	private String email;
	private String state;
	private int reported_count;
	
	public MemberDTO(String id, String pw, String name, String phone, String address, int birth_date, Date signup_date,
			int total_point, int extra_point, String manager_yn, int height, int weight, String email, String state ,int reported_count) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.birth_date = birth_date;
		this.signup_date = signup_date;
		this.total_point = total_point;
		this.extra_point = extra_point;
		this.manager_yn = manager_yn;
		this.height = height;
		this.weight = weight;
		this.email = email;
		this.state = state;
		this.reported_count = reported_count;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", phone=" + phone + ", address=" + address
				+ ", birth_date=" + birth_date + ", signup_date=" + signup_date + ", total_point=" + total_point
				+ ", extra_point=" + extra_point + ", manager_yn=" + manager_yn + ", height=" + height + ", weight="
				+ weight + ", email=" + email + ", state=" + state + ", reported_count=" + reported_count + "]";
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getBirth_date() {
		return birth_date;
	}

	public void setBirth_date(int birth_date) {
		this.birth_date = birth_date;
	}

	public Date getSignup_date() {
		return signup_date;
	}

	public void setSignup_date(Date signup_date) {
		this.signup_date = signup_date;
	}

	public int getTotal_point() {
		return total_point;
	}

	public void setTotal_point(int total_point) {
		this.total_point = total_point;
	}

	public int getExtra_point() {
		return extra_point;
	}

	public void setExtra_point(int extra_point) {
		this.extra_point = extra_point;
	}

	public String getManager_yn() {
		return manager_yn;
	}

	public void setManager_yn(String manager_yn) {
		this.manager_yn = manager_yn;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getReported_count() {
		return reported_count;
	}

	public void setReported_count(int reported_count) {
		this.reported_count = reported_count;
	}
	
}
