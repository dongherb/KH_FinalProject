package ms.com.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		System.out.println("loginSession 검사");
		
		if(request.getSession().getAttribute("loginSession") == null) {
			System.out.println("로그인페이지로 이동");
			response.sendRedirect("/member/toLoginPage");
			return false;
		}		
		return true;
	}	
	
}
