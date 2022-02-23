package ms.com.service;

import org.springframework.stereotype.Service;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;

@Service
public class ForecastDataService {

	// 해당날짜, 시간, 페이지번호(plusTime), 좌표들을 인자값으로 받아서 공공데이터를 불러옴
	public String getData(String base_date, String base_time, String plusTime, String nx, String ny) throws Exception {	// qRWtMzybLOETmXoaG6I5XQmamN9BSH%2FyqmmTj5iskRekMl15llAo3h6L250HU9pA2WKloOwnQ531Sd0kaqaPZA%3D%3D
    	
    	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=qRWtMzybLOETmXoaG6I5XQmamN9BSH%2FyqmmTj5iskRekMl15llAo3h6L250HU9pA2WKloOwnQ531Sd0kaqaPZA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(plusTime, "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(JSON)*/
        
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(base_date, "UTF-8")); /*발표날짜 20220101*/
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(base_time, "UTF-8")); /*05시 발표 0500*/
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); /*예보지점의 X 좌표값*/
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); /*예보지점의 Y 좌표값*/
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        rd.close();
        conn.disconnect();

        return sb.toString();
    }
	
	
	
	// 해당날짜, 시간, 페이지번호(plusTime)와 사용자의 주소를 이용해서 좌표값을 계산해 map으로 반환하는 매서드
	public Map<String, String> makeSutiedMap(String address){
		
		Map<String, String> map = new HashMap<>();
		
		if(address == null) {
			address = "0 서울 기본값";
		}
		
		String base_date;	// 기준날짜
		String base_time;	// 기준시각 (단위  0200:2시, 0500:5시, 0800:8시, 1100:11시, 1400:2시, 1700:5시, 2000:8시, 2300:11시)
		String plusTime = "";	// base_time = 1700, plusTime = 3 이면 2000시를 가르키게함
		
		String nx = "60";	// x좌표	// default : 서울 (60)
		String ny = "127";	// y좌표	// default : 서울 (127)
		
		
		// 기준날짜
		//---------------------------------------
		LocalDate nowDate = LocalDate.now();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		base_date = nowDate.format(formatter);

		// 기준시각 / 위치할 페이지
		//----------------------------------------
		LocalTime nowTime = LocalTime.now();
		formatter = DateTimeFormatter.ofPattern("HH");

		String formatedTime = nowTime.format(formatter);
		int timeHH = Integer.parseInt(formatedTime);
		
		if(timeHH <= 2) {	// 0(24), 1, 2
			
			Calendar cal = new GregorianCalendar();
			cal.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷 
			base_date = sdf.format(cal.getTime()); // String으로 저장
			
			base_time = "2300";
			plusTime += (timeHH + 1);
		}
		else if(timeHH <= 5) {	// 3, 4, 5
			base_time = "0200";
			plusTime += (timeHH - 2);
		}
		else if(timeHH <= 8) {	// 6, 7, 8
			base_time = "0500";
			plusTime += (timeHH - 5);
		}
		else if(timeHH <= 11) {	// 9, 10, 11
			base_time = "0800";
			plusTime += (timeHH - 8);
		}
		else if(timeHH <= 14) {	// 12, 13, 14
			base_time = "1100";
			plusTime += (timeHH - 11);
		}
		else if(timeHH <= 17) {	// 15, 16, 17
			base_time = "1400";
			plusTime += (timeHH - 14);
		}
		else if(timeHH <= 20) {	// 18, 19, 20
			base_time = "1700";
			plusTime += (timeHH - 17);
		}
		else {					// 21, 22, 23
			base_time = "2000";
			plusTime += (timeHH - 20);
		}
		
		// 사용자의 주소를 위치좌표로 변환
		//--------------------------------
		String firstAddress = (address.split(" "))[1];

		switch (firstAddress) {
			case "서울":
				nx = "60";	// x좌표
				ny = "127";	// y좌표
				break;
			case "부산":
				nx = "98";	// x좌표
				ny = "76";	// y좌표
				break;
			case "대구":
				nx = "89";	// x좌표
				ny = "90";	// y좌표
				break;
			case "인천":
				nx = "55";	// x좌표
				ny = "124";	// y좌표
				break;
			case "광주":
				nx = "58";	// x좌표
				ny = "74";	// y좌표
				break;
			case "대전":
				nx = "67";	// x좌표
				ny = "100";	// y좌표
				break;
			case "울산":
				nx = "102";	// x좌표
				ny = "84";	// y좌표
				break;
			case "세종특별자치시":
				nx = "66";	// x좌표
				ny = "103";	// y좌표
				break;
			case "경기":
				nx = "60";	// x좌표
				ny = "120";	// y좌표
				break;
			case "강원":
				nx = "73";	// x좌표
				ny = "134";	// y좌표
				break;
			case "충북":
				nx = "69";	// x좌표
				ny = "107";	// y좌표
				break;
			case "충남":
				nx = "68";	// x좌표
				ny = "100";	// y좌표
				break;
			case "전북":
				nx = "63";	// x좌표
				ny = "89";	// y좌표
				break;
			case "전남":
				nx = "51";	// x좌표
				ny = "67";	// y좌표
				break;
			case "경북":
				nx = "89";	// x좌표
				ny = "91";	// y좌표
				break;
			case "경남":
				nx = "91";	// x좌표
				ny = "77";	// y좌표
				break;
			case "제주특별자치도":
				nx = "52";	// x좌표
				ny = "38";	// y좌표
				break;
			case "이어도":
				nx = "28";	// x좌표
				ny = "8";	// y좌표
				break;
	
			default:
				nx = "60";	// x좌표
				ny = "127";	// y좌표
				break;
		}

		// map에 담기
		map.put("firstAddress", firstAddress);
		map.put("base_date", base_date);
		map.put("base_time", base_time);
		map.put("plusTime", plusTime);
		map.put("nx", nx);
		map.put("ny", ny);
		
		return map;
	}
	
	
}
