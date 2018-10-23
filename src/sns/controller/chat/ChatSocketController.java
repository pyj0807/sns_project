package sns.controller.chat;

import java.util.List;

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
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sockets.add(session);
		
	}
	
	
@Override
protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {


}

@Override
public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	sockets.remove(session);
}

}
