package sns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import sns.repository.JoinDao;

@Controller
public class JoinCotroller {
	
	@Autowired
	JoinDao jdao;
	
	@GetMapping("join.do")
	public String joinGetHandke() {
		
		return "";
	}
	
	
	
}
