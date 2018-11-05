package sns.controller.account;

import java.io.IOException;
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
import sns.repository.FollowRepository;
import sns.repository.Followmongoalert;

@Controller
public class FollowController {
	@Autowired
	FollowRepository follow;
	
	@Autowired
	Gson gson;
	
	@Autowired
	AlertService service;
	
	@Autowired
	Followmongoalert mongoalert;

	@ResponseBody
	@PostMapping("/follow.do")
	public String follow(@RequestParam Map map) {
		String myid = (String) map.get("myid");
		String otherid = (String) map.get("otherid");

		// 팔로우가 되어있는지 체크하는 맵
		Map checkmap = follow.CheckFollowing(map);
		Map mm = new HashMap<>();
		
		if (checkmap==null) {
			// 서로 팔로우가 안되어있을때 인서트 시도
			int r = follow.insertFollowing(map);
			int a = follow.insertFollower(map);
			// 인서트 성공
				mm.put("mode","on");
				int cnt = follow.getFollowerCnt(otherid);
				mm.put("followerCnt", cnt);
				
				Map sendMap=new HashMap<>();
				sendMap.put("mode", "following");
				sendMap.put("id", myid);
				sendMap.put("receiver", otherid);
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
		System.out.println(id);
		List list = follow.getFollowerList(id);
		map.put("list", list);
		return "sns.follower";
	}

	@GetMapping("/following.do")
	public String following(@RequestParam String id, ModelMap map) {
		List list = follow.getFollowingList(id);
		map.put("list", list);
		return "sns.following";
	}

}
