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
import sns.repository.FreeAlertService;

@Controller
public class ChatSocketController extends TextWebSocketHandler {
	@Autowired
	ChatDao ChatDao;

	@Autowired
	AlertService service;

	@Autowired
	Gson gson;

	@Autowired
	ChatMongoRepository mongochat;

	@Autowired
	FreeAlertService freeservice;

	List<WebSocketSession> sockets;

	public ChatSocketController() {
		sockets = new ArrayList<WebSocketSession>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sockets.add(session);
		freeservice.addSocket(session);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		Map userMap = (Map) session.getAttributes().get("user");
		String got = message.getPayload();
		Map map = gson.fromJson(got, Map.class);
		map.put("userNAME", (String) userMap.get("NAME"));

		String otherId = (String) map.get("otherId");

		String sendmsg = gson.toJson(map);

		List socketslist = new ArrayList<>();
		for (int i = 0; i < sockets.size(); i++) {
			socketslist.add(sockets.get(i).getAttributes().get("Id"));
		}

		List modeid = new ArrayList<>();
		Date time = new Date(System.currentTimeMillis());

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		map.put("jspsendtime", System.currentTimeMillis());
		modeid.add(map.get("id"));
		modeid.add(map.get("otherId"));
		String modeidd = gson.toJson(modeid);

		List a = new ArrayList<>();
		a.add(otherId);
		map.put("modeId", modeid);
		map.put("readid", otherId);
		map.put("sendtime", sf.format(time));
		map.put("readid", a);
		map.put("receive", otherId);
		mongochat.insertfreechat(map);

		String str = gson.toJson(map);
		TextMessage msg = new TextMessage(str);

		Map roominsert = new HashMap<>();
		roominsert.put("modeId", modeid);
		roominsert.put("lastsenddate", (long) (System.currentTimeMillis()));
		roominsert.put("lastformat", sf.format(time));
		roominsert.put(otherId, 1);
		roominsert.put((String) map.get("id"), 0);
		roominsert.put("cont", map.get("text"));
		roominsert.put("sendid", (String) map.get("id"));

		if (mongochat.chatroomcheck((String) map.get("id"), (String) map.get("otherId")).size() < 1) {
			mongochat.insertchatroom(roominsert);
		} else {
			mongochat.roomupdate((String) map.get("id"), (String) map.get("otherId"), sf.format(time), otherId,
					(String) map.get("text"));
			mongochat.roomcountupdate((String) map.get("id"), otherId);

		}

		List li = new ArrayList<>();
		for (int i = 0; i < service.size(); i++) {
			String userId = (String) service.list.get(i).getAttributes().get("Id");
			li.add(userId);

		}
		List humanlist = new ArrayList<>();
		humanlist.add(otherId);
		humanlist.add(userMap.get("ID"));

		for (int i = 0; i < humanlist.size(); i++) {
			if (socketslist.contains(humanlist.get(i))) {

			}
		}


		for (int i = 0; i < sockets.size(); i++) {
			if (sockets.get(i).getAttributes().get("Id").equals(otherId)
					|| sockets.get(i).getAttributes().get("Id").equals(userMap.get("ID"))) {
				sockets.get(i).sendMessage(msg);
			}
		}

		List<Map> othercount = mongochat.getcount(otherId);

		long count = 0;
		for (int i = 0; i < othercount.size(); i++) {

			long aa = Integer.parseInt(othercount.get(i).get(otherId).toString());
			count += aa;

		}

		Map recevier = new HashMap<>();// 상대 카운팅 얼럿 주는것
		recevier.put("mode", "count");
		recevier.put("defaultcnt", count);
		service.sendOne(recevier, otherId);

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sockets.remove(session);
		freeservice.removeSocket(session);

	}

}
