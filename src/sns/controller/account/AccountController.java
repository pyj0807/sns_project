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

import sns.repository.AccountRepository;
import sns.repository.BoardRepository;
import sns.repository.FollowRepository;

@Controller
public class AccountController {
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	FollowRepository follow;
	@Autowired
	AccountRepository accountRepository;
	
	@RequestMapping("/account.do")
	public String account(WebRequest wr, @RequestParam String id,ModelMap map) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		System.out.println("/account.do 들어온 페이지 이메일 : " + id);
		System.out.println("/acoount.do 내 이메일 : " + loginId);
		
		if (id.equals(loginId)) {
			return "redirect:/mypage.do";
		} else {
			List<Map> accountlist = boardRepository.findWriter(id);
			int size = accountlist.size();
			Map otherUser = accountRepository.getOneUserInfo(id);
			wr.setAttribute("otherUser", otherUser, wr.SCOPE_REQUEST);
			wr.setAttribute("id", id, wr.SCOPE_REQUEST);
			wr.setAttribute("size", size, wr.SCOPE_REQUEST);
			wr.setAttribute("accountlist", accountlist, WebRequest.SCOPE_REQUEST);
		}
		
		Map followingcheck =new HashMap<>();
		followingcheck.put("myid",loginId);
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
