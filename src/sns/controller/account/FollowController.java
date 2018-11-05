package sns.controller.account;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.google.gson.Gson;

import sns.repository.AlertService;
import sns.repository.BoardRepository;
import sns.repository.FollowLikemongoalert;
import sns.repository.FollowRepository;

@Controller
public class FollowController {
	@Autowired
	FollowRepository follow;
	
	@Autowired
	BoardRepository board;
	
	@Autowired
	Gson gson;
	
	@Autowired
	AlertService service;
	
	@Autowired
	FollowLikemongoalert mongoalert;

	@ResponseBody
	@PostMapping("/follow.do")
	public String follow(@RequestParam Map map) {
		String myid = (String) map.get("myid");
		String otherid = (String) map.get("otherid");

		// 팔로우가 되어있는지 체크하는 맵
		Map checkmap = follow.CheckFollowing(map);
		Map mm = new HashMap<>();
		SimpleDateFormat sf =new SimpleDateFormat("YYYY-MM-dd HH:mm");
		if (checkmap==null) {
			// 서로 팔로우가 안되어있을때 인서트 시도
			int r = follow.insertFollowing(map);
			int a = follow.insertFollower(map);
			// 인서트 성공
				mm.put("mode","on");
				int cnt = follow.getFollowerCnt(otherid);
				mm.put("followerCnt", cnt);
				
				Map sendMap=new HashMap<>();
				sendMap.put("mode", "followinglike");
				sendMap.put("moded", "follow");
				sendMap.put("id", myid);
				sendMap.put("receiver", otherid);
				sendMap.put("senddate", (long)System.currentTimeMillis());
				sendMap.put("content", " 님이 팔로우 하였습니다.");
				sendMap.put("senddatejsp", sf.format(System.currentTimeMillis()));
				mongoalert.Mongofollowservice(sendMap);
				TextMessage msg =new TextMessage(gson.toJson(sendMap));
				
				for(int i=0;i<service.list.size();i++) {
					if(service.list.get(i).getAttributes().get("userId").equals(otherid)) {
						try {
							service.list.get(i).sendMessage(msg);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				
				
				return gson.toJson(mm);
		}else {
			// 이미 팔로우중일때 이쪽으로
			// 팔로우 취소
			Map sendMap=new HashMap<>();
			sendMap.put("mode", "followinglike");
			sendMap.put("moded", "follow");
			sendMap.put("id", myid);
			sendMap.put("receiver", otherid);
			sendMap.put("senddate", (long)System.currentTimeMillis());
			sendMap.put("content", " 님이 팔로우를 취소 하였습니다.");
			sendMap.put("senddatejsp", sf.format(System.currentTimeMillis()));
			mongoalert.Mongofollowservice(sendMap);
			TextMessage msg =new TextMessage(gson.toJson(sendMap));
			for(int i=0;i<service.list.size();i++) {
				if(service.list.get(i).getAttributes().get("userId").equals(otherid)) {
					try {
						service.list.get(i).sendMessage(msg);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			follow.delFollower(map);
			follow.delFollowing(map);
			mm.put("mode","off");
			int cnt = follow.getFollowerCnt(otherid);
			mm.put("followerCnt", cnt);
			return gson.toJson(mm);
		}

	}

	@GetMapping("/follower.do")
	public String follower(@RequestParam String id, ModelMap map) {
		List listuu = follow.getFollowerList(id);
		List<Map> list = new ArrayList<>();
		for(int i=0;i<listuu.size();i++) {
			list.add((Map)board.getOneUserInfo((String)listuu.get(i)));
		}
		map.put("list", list);
		return "sns.follower";
	}

	@GetMapping("/following.do")
	public String following(@RequestParam String id, ModelMap map) {
		List listuu = follow.getFollowingList(id);
		List<Map> list = new ArrayList<>();
		for(int i=0;i<listuu.size();i++) {
			list.add((Map)board.getOneUserInfo((String)listuu.get(i)));
		}
		map.put("list", list);
		return "sns.following";
	}

}
