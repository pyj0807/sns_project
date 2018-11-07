package sns.controller.chat;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import sns.repository.FollowLikemongoalert;
import sns.repository.FreeAlertService;

@Controller
public class AllSocketController extends TextWebSocketHandler {
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

	@Autowired
	FollowLikemongoalert follolikemongo;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String id = (String) session.getAttributes().get("userId");
		service.addSocket(session);

		List lll = new ArrayList<>();

		List servicelist = new ArrayList<>();
		for (int i = 0; i < service.size(); i++) {
			servicelist.add(service.list.get(i).getAttributes().get("userId"));
		}

		List<Map> qq = follolikemongo.mongofollowserviceall(id);
		String aaa = "";
		qq.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("senddate");
				long n2 = (long) o2.get("senddate");

				if (n1 < n2) {
					return 1;
				} else if (n1 > n2) {
					return -1;
				} else {
					return 0;
				}
			}
		});

		Map alertMap = new HashMap<>();
		alertMap.put("mode", "defaultalert");
		alertMap.put("str", qq);
		session.sendMessage(new TextMessage(gson.toJson(alertMap)));

		Map map = new HashMap<>();
		for (int iii = 0; iii < freeservice.listt.size(); iii++) {

		}
		List<Map> counting = mongodao.getcount((String) session.getAttributes().get("userId"));
		List<Map> ll = new ArrayList<>();
		long count = 0;
		map.put("mode", "count");
		for (int i = 0; i < counting.size(); i++) {

			long a = Integer.parseInt(counting.get(i).get(id).toString());
			count += a;

		}
		map.put("defaultcnt", count);
		TextMessage msg = new TextMessage(gson.toJson(map));
		session.sendMessage(msg);

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		service.removeSocket(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

	}

}
