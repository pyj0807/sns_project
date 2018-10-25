package sns.controller.account;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WriteController {
	
	@GetMapping("/write.do")
	public String write() {
		return "sns.write";
	}	
	
}
