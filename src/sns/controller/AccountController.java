package sns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class AccountController {

	@RequestMapping("/home.do")
	public String mypage() {
		return "sns.mypage";
	}
	
	@RequestMapping("/write.do")
	public String write() {
		return "sns.write";
	}
	
	
}
