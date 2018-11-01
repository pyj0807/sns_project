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
		
		service.addSocket(session);
		
		List lll=new ArrayList<>();
		
		/*List servicelist=new ArrayList<>();
		for (int i = 0; i < service.size(); i++) {
			servicelist.add(service.list.get(i).getAttributes().get("userId"));
		}
		*/
		System.out.println("세션 저장된 아이디입니다."+(String)session.getAttributes().get("userId")+"ㅁㅇ롬옴오");
		long count =0;
		String countlistt =mongodao.getcountt((String)session.getAttributes().get("Id"));
		
		List<Map> countlist= gson.fromJson(countlistt, List.class);
		/*System.out.println("뽑아온 숫자입니다.ㅗㅎ롷롫"+countlist);*/
		for(int i=0;i<countlist.size();i++) {
			//System.out.println("꺄르르="+countlist.get(i).get((String)session.getAttributes().get("userId")));
			long ll=(long)countlist.get(i).get((String)session.getAttributes().get("Id"));
			count+=ll;
			/*System.out.println("꺄르르"+count);*/
		}
		Map map =new HashMap<>();
		map.put("mode", "count");
		map.put("defaultcnt", count);
/*		System.out.println(map.toString()+"내놔라!!");*/
		TextMessage msg =new TextMessage(gson.toJson(map));
		session.sendMessage(msg);
		
		
		
		/*System.out.println(session.getAttributes());
		System.out.println(service.size());*/
/*	long count=	mongodao.getcount((String)session.getAttributes().get("userId"));
		map.put("defaultcnt", count);
		TextMessage msg =new TextMessage(gson.toJson(map));
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
