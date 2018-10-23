package sns.controller.chat;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatSocketController extends TextWebSocketHandler{
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	
@Override
protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	// TODO Auto-generated method stub

}

}
