package sns.controller.account;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import sns.repository.FollowRepository;

@Controller
public class FollowController {
	@Autowired
	FollowRepository follow;

	@ResponseBody
	@PostMapping("/follow.do")
	public String follow(@RequestParam Map map) {
		String myid = (String) map.get("myid");
		String otherid = (String) map.get("otherid");

		System.out.println("팔로우버튼클릭 누른사람아이디 : " + myid);

		// 팔로우가 되어있는지 체크하는 맵
		Map checkmap = follow.CheckFollowing(map);
		System.out.println("팔로우 체크 : " + checkmap);
		if (checkmap==null) {
			// 서로 팔로우가 안되어있을때 인서트 시도
			int r = follow.insertFollowing(map);
			int a = follow.insertFollower(map);
			if (r != 1) {
				// 인서트 실패
				follow.delFollowing(map);
				follow.delFollower(map);
				return "{\"mode\":\"err\"}";
			} else {
				// 인서트 성공
				return "{\"mode\":\"on\"}";
			}
		}else {
			// 이미 팔로우중일때 이쪽으로
			// 팔로우 취소
			follow.delFollower(map);
			follow.delFollowing(map);
			return "{\"mode\":\"off\"}";
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
