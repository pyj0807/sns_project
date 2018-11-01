package sns.controller.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import sns.club.chat.ClubChatSocketController;
import sns.repository.AlertService;
import sns.repository.ChatDao;
import sns.repository.ChatMongoRepository;
import sns.repository.FreeAlertService;


@Controller
public class AllSocketController extends TextWebSocketHandler{
	@Autowired
	ChatDao ChatDao;
	
	@Autowired
	AlertService service;
	
	@Autowired
	Gson gson;
	
	@Autowired
	ChatMongoRepository mongodao;
	
	
	
	@Autowired
	FreeAlertService freeservice;
	
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String id=(String)session.getAttributes().get("userId");
		service.addSocket(session);
		
		List lll=new ArrayList<>();
		
		List servicelist=new ArrayList<>();
		for (int i = 0; i < service.size(); i++) {
			servicelist.add(service.list.get(i).getAttributes().get("userId"));
		}
		
		
		
		
		/*System.out.println(session.getAttributes());
		System.out.println(service.size());*/
/*	long count=	mongodao.getcount((String)session.getAttributes().get("userId"));*/
		Map map =new HashMap<>();
		for(int iii=0;iii<freeservice.listt.size();iii++) {
			
			
		}
		List<Map> counting=mongodao.getcount((String)session.getAttributes().get("userId"));
		System.out.println(counting);
		List<Map> ll=new ArrayList<>();
		long count=0;
		System.out.println("gkgkgkgkgk="+counting);
		map.put("mode", "count");
		for(int i=0;i<counting.size();i++) {
			
			long a=Integer.parseInt(counting.get(i).get(id).toString());
			count+=a;
			
		}
		System.out.println("꺄꺄꺄="+count);
		map.put("defaultcnt", count);
		TextMessage msg =new TextMessage(gson.toJson(map));
		session.sendMessage(msg);
	/*	for(int i=0;i<counting.size();i++) {
			long a=(long)counting.get(i).get((String)session.getAttributes().get("userId"));
			System.out.println("호호호호홓="+a);
		}
		*/
	/*	for(int i=0;i<countingstr.length;i++) {
			ll.add(gson.fromJson(countingstr[i], Map.class));
		}*/
	//	System.out.println("꺄르르르"+countingstr);
		/*System.out.println(countingstr);*/
	
	/*	Map map =new HashMap<>();
		map.put("mode", "count");
		map.put("defaultcnt", count);
		String myid=(String)session.getAttributes().get("userId");
		System.out.println("클럽소켓사이즈="+freeservice.listt.size()+myid);
		for(int i=0;i<freeservice.size();i++) {
			if(!servicelist.contains((String)freeservice.listt.get(i).getAttributes().get("userId"))) {
				session.sendMessage(msg);
		}
		
	}*/
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		service.removeSocket(session);
	}
	
	
@Override
protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	

}

}
