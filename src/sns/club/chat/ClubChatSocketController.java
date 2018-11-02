package sns.club.chat;

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
import sns.repository.FreeAlertService;
import sns.repository.ClubChatMongoDeleteRepository;
import sns.repository.Clubmongochat;


@Controller
public class ClubChatSocketController extends TextWebSocketHandler{
	@Autowired
	ChatDao ChatDao;
	
	@Autowired
	AlertService service;
	
	@Autowired
	Gson gson;
	
	@Autowired
	Clubmongochat mongo;
	
	@Autowired
	ClubChatMongoDeleteRepository mongoremove;
	
	
	List<WebSocketSession> sockets;
	public ClubChatSocketController() {
		sockets= new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sockets.add(session);
		
		
		
		
	}
	
	
	
@Override
protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	
	
	
	Map userMap=(Map)session.getAttributes().get("user");
		System.out.println("저장된 유저 아이디="+userMap.get("ID"));
		String got=message.getPayload();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Map gotmap=gson.fromJson(got, Map.class);
		gotmap.put("ID", userMap.get("ID"));
		gotmap.put("sendtime", sf.format(System.currentTimeMillis()));
		gotmap.put("userNAME", userMap.get("NAME"));
		System.out.println((String)gotmap.get("contentid"));
		
		Map li =mongoremove.rommmainid((String)gotmap.get("contentid"));
		String str="";
		
		   System.out.println("하오하오="+str);
			TextMessage msg =new TextMessage(gson.toJson(gotmap));
		Map savedata=new HashMap<>();
		savedata.put("contentid", gotmap.get("contentid"));
		savedata.put("content", gotmap.get("content"));
		savedata.put("userNAME", userMap.get("NAME"));
		savedata.put("ID", userMap.get("ID"));
		savedata.put("sendtime", sf.format(System.currentTimeMillis()));
		savedata.put("sendtimelong", System.currentTimeMillis());
		savedata.put("readagency",new ArrayList<>());
		savedata.put("mainid", (String)li.get("mainid"));
		
		mongo.clubchatinsert(savedata);
		
		List mm=mongo.getAllclub((String)gotmap.get("contentid"));
		Map aa=(Map)mm.get(0);
		System.out.println(aa);
		List clublist=new ArrayList<>();
	

		
		List clublistall =(List)aa.get("agency");
	
		
		for(int i=0;i<clublistall.size();i++) {
			clublist.add(clublistall.get(i));
			
		}
		List alllist=new ArrayList<>();
	/*	for(int i=0;i<service.size();i++) {
			alllist.add(service.list.get(i).getAttributes().get("userId"));
			System.out.println(service.list.get(i).getAttributes().get("userId"));
		}*/
		for(int i=0;i<sockets.size();i++) {
			String id= (String)sockets.get(i).getAttributes().get("Id");
			System.out.println(id);
			if(clublist.contains(id)) {
				sockets.get(i).sendMessage(msg);
			}
		}
		


	
	

}










@Override
public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	sockets.remove(session);
	
	
	
}

}
