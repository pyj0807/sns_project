package sns.controller.chat;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import sns.repository.AlertService;
import sns.repository.ChatDao;


@Controller
public class ChatSocketController extends TextWebSocketHandler{
	@Autowired
	ChatDao ChatDao;
	
	@Autowired
	AlertService service;
	
	@Autowired
	Gson gson;
	
	List<WebSocketSession> sockets;
	public ChatSocketController() {
		sockets= new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sockets.add(session);
		
		System.out.println("소켓사이즈="+sockets.size());
		System.out.println("소켓에서 서비스사이즈="+service.size());
		
		System.out.println("입장시 소켓 사이즈="+sockets.size());
		System.out.println("입장시 서비스 사이즈="+service.size());
		
		
	}
	
	
	
	
@Override
protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	
	Map userMap=(Map)session.getAttributes().get("user");
		System.out.println("저장된 유저 아이디="+userMap.get("ID"));
		String got=message.getPayload();
		Map map =gson.fromJson(got, Map.class);
		map.put("user",userMap);
		
		String otherId=(String)map.get("otherId");
		System.out.println(otherId);
		String sendmsg=gson.toJson(map);
		
		List li=new ArrayList<>();
		for(int i=0;i<service.size();i++) {
			String userId=(String)service.list.get(i).getAttributes().get("userId");
			li.add(userId);
			
		}
		
		
		for(int i=0;i<sockets.size();i++) {
			
			System.out.println("zzz="+service.list.get(i).getAttributes().get("userId"));
			if(li.contains(otherId)) {
				System.out.println("otherId");
				service.list.get(i).sendMessage(message);
				
				service.sendOne(map, (String)service.list.get(i).getAttributes().get("userId"));
				
			}
			sockets.get(i).sendMessage(message);
		}
		
		

	
	

}










@Override
public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	sockets.remove(session);
	
	
}

}
