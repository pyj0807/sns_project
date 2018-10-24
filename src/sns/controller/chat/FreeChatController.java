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
import org.springframework.web.context.request.WebRequest;

import sns.repository.ChatDao;
import sns.repository.ChatMongoRepository;

@RequestMapping("/chat")
@Controller
public class FreeChatController {

		@Autowired
		ChatDao chatdao;
		
		@Autowired
		ChatMongoRepository mongochat;
	
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
	public String freechatviewController(ModelMap map,@RequestParam Map pp,WebRequest wr) {
		
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		String id2 =(String)pp.get("id");
		List<Map> allchat=mongochat.getfreechat(id, id2);
		
		map.put("allchat", allchat);
		
		map.put("otherId", pp.get("id"));
		List li =new ArrayList<>();
		li=chatdao.chatgetall();
		map.put("chatlist",li );
		System.out.println(li.toString());
		return "chat.freeview";
	}
}
