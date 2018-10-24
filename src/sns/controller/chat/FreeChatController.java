package sns.controller.chat;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sns.repository.ChatDao;

@RequestMapping("/chat")
@Controller
public class FreeChatController {

		@Autowired
		ChatDao chatdao;
	
	@RequestMapping("/freechat.do")
	public String freechatController(ModelMap map) {
		List li =new ArrayList<>();
		li=chatdao.chatgetall();
		
		map.put("frends", li);
		
		for(int i=0;i<li.size();i++) {
			Map aa=(Map)li.get(i);
		
		}
		return "chat.free";
	}
	
	
	@GetMapping("/freechatview.do")
	public String freechatviewController(ModelMap map,@RequestParam Map pp) {
		
		map.put("otherId", pp.get("id"));
		List li =new ArrayList<>();
		li=chatdao.chatgetall();
		map.put("chatlist",li );
		System.out.println(li.toString());
		return "chat.freeview";
	}
}
