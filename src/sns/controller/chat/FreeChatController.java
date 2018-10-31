package sns.controller.chat;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public String freechatController(ModelMap map,WebRequest wr) {
		List li =new ArrayList<>();
		li=chatdao.followchatgetall((String)wr.getAttribute("Id", wr.SCOPE_SESSION));
		
		map.put("frends", li);
		
		for(int i=0;i<li.size();i++) {
			Map aa=(Map)li.get(i);
		
		}
		List<Map> roomlist=mongochat.getallroom((String)wr.getAttribute("Id", wr.SCOPE_SESSION));
		
		if(roomlist!=null) {
		roomlist.sort(new Comparator<Map>() {
	         @Override
	         public int compare(Map o1, Map o2) {
	            long n1= (long)o1.get("lastsenddate");
	            long n2= (long)o2.get("lastsenddate");
	            
	            if(n1<n2) {
	               return 1;
	            }else if(n1>n2) {
	               return -1;
	            }else {
	               return 0;
	            }
	         }
	      });
		/*for(int i=0;i<roomlist.size();i++) {
			roomlist.get(i).get(key)
		}*/
		
		int aa=0;
		Map mmm=new HashMap<>();
		List room=new ArrayList<>();
		for(int i=0;i<roomlist.size();i++) {
			aa=(int)roomlist.get(i).get((String)wr.getAttribute("Id", wr.SCOPE_SESSION));
			
			roomlist.get(i).put("num", aa);
		}
		
		map.put("freelist", roomlist);
		
		
		}
		return "chat.free";
	}
	
	
	@GetMapping("/freechatview.do")
	public String freechatviewController(ModelMap map,@RequestParam Map pp,WebRequest wr) {
		
		String id = (String)wr.getAttribute("Id", wr.SCOPE_SESSION);
		String id2 =(String)pp.get("id");//상대아이디
		/*System.out.println("실제 아더아이디="+id2);*/
		
	/*	if(mongochat.getcount(id)>0) {*/
			mongochat.removecount(id,(String)wr.getAttribute("Id", wr.SCOPE_SESSION),id2);
			System.out.println("지워짐");
		/*}*/
		
		List list=chatdao.followchatgetall((String)wr.getAttribute("Id", wr.SCOPE_SESSION));
		List<Map> allchat=mongochat.getfreechat(id, id2);
		mongochat.roomcountupdatedown(id, id2);
		map.put("allchat", allchat);
		
		map.put("otherId", pp.get("id"));
		List li =new ArrayList<>();
		li=chatdao.chatgetall();
		map.put("chatlist",li );
		map.put("friends", list);
		System.out.println(li.toString());
		return "chat.freeview";
	}
	
	
	
	@GetMapping(path="chatremovecontroller.do", produces="application/json;charset=UTF-8") //ajax용
	public void removecounting(@RequestParam Map param) {
		System.out.println("아작스 넘어온값="+param);
		
		
		
	}
	
	
	
	
	
	
}
