package sns.controller.chat;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import sns.repository.AlertService;
import sns.repository.ChatDao;
import sns.repository.ChatMongoRepository;


@Controller
public class ChatSocketController extends TextWebSocketHandler{
	@Autowired
	ChatDao ChatDao;
	
	@Autowired
	AlertService service;
	
	@Autowired
	Gson gson;
	
	@Autowired
	ChatMongoRepository mongochat;
	
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
		System.out.println("저장된 유저 아이디="+userMap.get("Id"));
		String got=message.getPayload();
		Map map =gson.fromJson(got, Map.class);
		map.put("userNAME",(String)userMap.get("NAME"));
		System.out.println(userMap.get("NAME"));
		String otherId=(String)map.get("otherId");
		System.out.println(otherId);
		String sendmsg=gson.toJson(map);
		
		List socketslist=new ArrayList<>();
		for(int i=0;i<sockets.size();i++) {
			socketslist.add(sockets.get(i).getAttributes().get("Id"));
		}
		
		
		List modeid=new ArrayList<>();
		Date time =new Date(System.currentTimeMillis());
		System.out.println(" 유저아이디유="+map.get("Id"));
		System.out.println(time.toString());
	
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		/*df.format(time);*/
		
		map.put("jspsendtime",System.currentTimeMillis());
		modeid.add(map.get("id"));
		modeid.add(map.get("otherId"));
		String modeidd=gson.toJson(modeid);
		
		List a=new ArrayList<>();
		a.add(otherId);
		map.put("modeId", modeid);
		map.put("readid", otherId);
		map.put("sendtime",sf.format(time) );
		map.put("readid",a );
		mongochat.insertfreechat(map);
		
		String str= gson.toJson(map);
		TextMessage msg =new TextMessage(str);
		
		Map roominsert =new HashMap<>();
		roominsert.put("modeId", modeid);
		roominsert.put("lastsenddate", (long)(System.currentTimeMillis()));
		roominsert.put("lastformat", sf.format(time));
		

		
		
		
		if(mongochat.chatroomcheck((String)map.get("id"),(String)map.get("otherId")).size()<1) {
			mongochat.insertchatroom(roominsert);
		}else {
			mongochat.roomupdate((String)map.get("id"), (String)map.get("otherId"),sf.format(time),otherId);
		}
		
		List li=new ArrayList<>();
		for(int i=0;i<service.size();i++) {
			String userId=(String)service.list.get(i).getAttributes().get("Id");
			li.add(userId);
			
		}
		List humanlist=new ArrayList<>();
		humanlist.add(otherId);
		humanlist.add(userMap.get("ID"));
		
		for(int i=0;i<humanlist.size();i++) {
			if(socketslist.contains(humanlist.get(i))) {
				
				
				
			}
		}
		
		
		
		for(int i=0;i<sockets.size();i++) {
			
			System.out.println("zzz="+service.list.get(i).getAttributes().get("Id"));
			/*if(li.contains(otherId)) {
				System.out.println("otherId");
				service.list.get(i).sendMessage(message);
				
				service.sendOne(map, (String)service.list.get(i).getAttributes().get("userId"));
				
			}*/
			System.out.println("");
			
			if(sockets.get(i).getAttributes().get("Id").equals(otherId)||sockets.get(i).getAttributes().get("Id").equals(userMap.get("ID"))) {
			sockets.get(i).sendMessage(msg);
			}
		}
		
		
		
		//밑에는 카운팅 넘기는용
		long l=mongochat.getcount(otherId);
		for(int i=0;i<service.size();i++) {
			if(service.list.get(i).getAttributes().get("userId").equals(otherId)) {
				Map mappp =new HashMap<>();
				mappp.put("mode", "count");
				mappp.put("defaultcnt", l);
				TextMessage msgggg =new TextMessage(gson.toJson(mappp));
				service.list.get(i).sendMessage(msgggg);
			}
			
		}
		
		
		

	
	

}










@Override
public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	sockets.remove(session);
	
	
}

}
