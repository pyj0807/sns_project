package sns.controller.chat;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import sns.repository.AlertService;
import sns.repository.ChatDao;
import sns.repository.ChatMongoRepository;
import sns.repository.ClubChatMongoDeleteRepository;
import sns.repository.Clubmongochat;

class TimeSorter implements Comparator<Integer> {

	public int compare(Integer a, Integer b) {
		return (Integer) (a - b);
	}

}

@RequestMapping("/chat")
@Controller
public class FreeChatController {

	@Autowired
	ChatDao chatdao;

	@Autowired
	AlertService service;

	@Autowired
	ChatMongoRepository mongochat;

	@Autowired
	ServletContext ctx;

	@Autowired
	Clubmongochat clubmongo;

	@Autowired
	ClubChatMongoDeleteRepository mongoremove;

	@RequestMapping("/freechat.do")
	public String freechatController(ModelMap map, WebRequest wr, @RequestParam Map ww) {
		List li = new ArrayList<>();
		li = chatdao.followchatgetall((String) wr.getAttribute("userId", wr.SCOPE_SESSION));

		if (ww.get("zz") != null) {
			wr.setAttribute("cluballon", ww.get("cluballon"), wr.SCOPE_REQUEST);
		}

		if (ww.get("cluballon") != null) {
			wr.setAttribute("cluballon", ww.get("cluballon"), wr.SCOPE_REQUEST);
		}
		map.put("frends", li);

		for (int i = 0; i < li.size(); i++) {
			Map aa = (Map) li.get(i);

		}
		List<Map> roomlist = mongochat.getallroom((String) wr.getAttribute("Id", wr.SCOPE_SESSION));

		if (roomlist != null) {
			roomlist.sort(new Comparator<Map>() {
				@Override
				public int compare(Map o1, Map o2) {
					long n1 = (long) o1.get("lastsenddate");
					long n2 = (long) o2.get("lastsenddate");

					if (n1 < n2) {
						return 1;
					} else if (n1 > n2) {
						return -1;
					} else {
						return 0;
					}
				}
			});

			roomlist.sort(new Comparator<Map>() {
				@Override
				public int compare(Map o1, Map o2) {
					long n1 = Integer.parseInt(o1.get((String) wr.getAttribute("userId", wr.SCOPE_SESSION)).toString());
					long n2 = Integer.parseInt(o2.get((String) wr.getAttribute("userId", wr.SCOPE_SESSION)).toString());

					if (n1 < n2) {
						return 1;
					} else if (n1 > n2) {
						return -1;
					} else {
						return 0;
					}
				}
			});

			/*
			 * for(int i=0;i<roomlist.size();i++) { roomlist.get(i).get(key) }
			 */

			int aa = 0;
			Map mmm = new HashMap<>();
			List room = new ArrayList<>();
			for (int i = 0; i < roomlist.size(); i++) {
				aa = (int) roomlist.get(i).get((String) wr.getAttribute("Id", wr.SCOPE_SESSION));

				roomlist.get(i).put("num", aa);
			}

			map.put("freelist", roomlist);

		}

		TimeSorter sr = new TimeSorter();
		List<Map> lii = clubmongo.getAllopenChat();

		lii.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("createdate");
				long n2 = (long) o2.get("createdate");

				if (n1 < n2) {
					return 1;
				} else if (n1 > n2) {
					return -1;
				} else {
					return 0;
				}
			}
		});

		map.put("clubAll", lii);

		List<Map> l = clubmongo.clubmyall((String) wr.getAttribute("userId", wr.SCOPE_SESSION));
		l.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("createdate");
				long n2 = (long) o2.get("createdate");

				if (n1 < n2) {
					return 1;
				} else if (n1 > n2) {
					return -1;
				} else {
					return 0;
				}
			}
		});
		map.put("clubmyAll", l);

		return "chat.free";
	}

	@GetMapping("/freechatview.do")
	public String freechatviewController(ModelMap map, @RequestParam Map pp, WebRequest wr) {

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		String id2 = (String) pp.get("id");// 상대아이디

		mongochat.removecount(id, (String) wr.getAttribute("Id", wr.SCOPE_SESSION), id2);

		List list = chatdao.followchatgetall((String) wr.getAttribute("Id", wr.SCOPE_SESSION));
		List<Map> allchat = mongochat.getfreechat(id, id2);
		mongochat.roomcountupdatedown(id, id2);
		map.put("allchat", allchat);

		map.put("otherId", pp.get("id"));
		List li = new ArrayList<>();
		li = chatdao.chatgetall();
		map.put("chatlist", li);
		map.put("friends", list);
		return "chat.freeview";
	}

	@GetMapping(path = "chatremovecontroller.do", produces = "application/json;charset=UTF-8") // ajax용
	public void removecounting(@RequestParam Map param, HttpSession session) {
		String otherId = (String) param.get("otherId");
		mongochat.roomcountupdatedown((String) param.get("id"), (String) param.get("otherId"));
		List<Map> othercount = mongochat.getcount((String) param.get("id"));

		long count = 0;
		for (int i = 0; i < othercount.size(); i++) {

			if (othercount.get(i).get((String) param.get("id")) != null) {
				long aa = Integer.parseInt(othercount.get(i).get((String) param.get("id")).toString());
				count += aa;
			}

		}

		Map re = new HashMap<>();
		re.put("mode", "count");
		if (count == 0) {
			re.put("defaultcnt", 0);
		} else {

			re.put("defaultcnt", count);
		}
		service.sendOne(re, (String) param.get("id"));

	}

}
