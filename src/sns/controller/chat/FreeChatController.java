package sns.controller.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/chat")
@Controller
public class FreeChatController {

	@RequestMapping("/freechat.do")
	public String freechatController() {
		
		return "chat.free";
	}
	
	
	@RequestMapping("/freechatview.do")
	public String freechatviewController() {
		return "";
	}
}
