package sns.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter extends HttpFilter {
	@Override
	protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		//1.세션뽑기
		HttpSession session = req.getSession();
		String logincondition = (String)session.getAttribute("auth");
		
		String uri = req.getRequestURI().substring(12);
		String query = req.getQueryString();
		String path="";
		if(query==null) { //파라미터값이null일경우
			path = uri;
		}else { //있을경우
			path = uri+"?"+query; //파라미터하나밖에안됨
		}
	
		if(logincondition!=null) {//로그인성공시
			chain.doFilter(req, res); // 필터통과
		}else { //로그인안되있을경우처리
			session.setAttribute("dest", path);
			res.sendRedirect(req.getContextPath()+"/login.do");
		}
	}
}
