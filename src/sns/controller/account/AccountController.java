package sns.controller.account;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import sns.repository.BoardRepository;
import sns.repository.FollowRepository;

@Controller
public class AccountController {
	@Autowired
	BoardRepository boardRepository;

	@Autowired
	FollowRepository follow;

	@RequestMapping("/account.do")
	public String account(WebRequest wr, @RequestParam String id,ModelMap map) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginEmail = (String) user.get("EMAIL");
		System.out.println("/account.do 들어온 페이지 이메일 : " + id);
		System.out.println("/acoount.do 내 이메일 : " + loginEmail);
		
		if (id.equals(loginEmail)) {
			return "redirect:/mypage.do";
		} else {
			List<Map> accountlist = boardRepository.findWriter(id);
			wr.setAttribute("id", id, wr.SCOPE_REQUEST);
			wr.setAttribute("accountlist", accountlist, WebRequest.SCOPE_REQUEST);
		}
		
		Map followingcheck =new HashMap<>();
		followingcheck.put("myid",loginEmail);
		followingcheck.put("otherid",id);
		
		Map cnt =follow.CheckFollowing(followingcheck);
		System.out.println("팔로잉체크="+cnt);
		map.put("check",cnt);
		
		int followerCnt = follow.getFollowerCnt(id);
		int followingCnt = follow.getFollowingCnt(id);
		wr.setAttribute("followerCnt", followerCnt, wr.SCOPE_REQUEST);
		wr.setAttribute("followingCnt", followingCnt, wr.SCOPE_REQUEST);

		return "sns.account";
	}

}
