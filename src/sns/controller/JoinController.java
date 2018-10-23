package sns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JoinController {
	
	@RequestMapping("/join.do")
	public String joinHandle() {
		return "index/join";
	}
}
