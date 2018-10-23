package sns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Controller
public class WebSocketController extends TextWebSocketHandler{
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 클라이언트측에서 WebSocket 객체를 생성해서 연결이 될 때.
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 클라이언트측에서 사용중인 WebSocket 이 종료 될때.
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("sss");
	}
}
