package sns.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import sns.repository.LoingDao;

@Controller
public class IndexController {
	
	@Autowired
	LoingDao ldao;
	
	@RequestMapping("/index.do")
	public String index() {
		return "sns.home";
	}
	
	@GetMapping("/login.do")
	public String index(WebRequest wr ) {
		System.out.println("index 옴");
		
		if(wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
			return "/index/login";
		}else {
			return "sns.home";
		}
	}
	
	@PostMapping("/login.do")
	public String loginHandle(WebRequest wr, ModelMap map) {
		System.out.println("login 옴");
		
		String id = (String)wr.getParameter("id");
		String subid = (String)wr.getParameter("subid");
		
		String pass = (String)wr.getParameter("pass");
		System.out.println("id="+id);
		System.out.println("subid="+subid);
		
		Map data = new HashMap<>();
		data.put("email", id);
		data.put("pass", pass);
		
		System.out.println("data = " + data);
		
		Map log = ldao.login(data);
		
		if(log != null) {
			
			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("user",log, wr.SCOPE_SESSION);
			
			return "sns.home";
		
		}else {
			
			return "/index/login";
		}
	}
}
