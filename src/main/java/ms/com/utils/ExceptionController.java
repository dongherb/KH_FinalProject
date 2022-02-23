package ms.com.utils;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 모든 컨트롤러에서 발생하는 예외를 다 잡아주는 어노테이션
// @ ControllerAdvice
public class ExceptionController {
	
	// DAO , Service , Controller 모두 throws Exception한다면 예외를 가로채가는 어노테이션
	@ExceptionHandler
	public String toError(Exception e) {
		System.out.println("익셉션 클래스 실행");
		e.printStackTrace();
		return "error";
	}
}
