package sns.controller.account;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

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
	@Autowired
	Gson gson;
	
	// 다른 회원 페이지
	@RequestMapping("/account.do")
	public String account(WebRequest wr, @RequestParam String id,ModelMap map) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		
		if (id.equals(loginId)) {
			// 파라미터값 id와 로그인한 id가 같으면 마이페이지로 리다이렉트
			return "redirect:/mypage.do";
		} else {
			// 다른 회원이 쓴 글목록 리스트와 사이즈(글개수)
			List<Map> accountlist = boardRepository.findWriter(id);
			int size = accountlist.size();
			Map otherUser = accountRepository.getOneUserInfo(id);
			wr.setAttribute("otherUser", otherUser, wr.SCOPE_REQUEST);
			wr.setAttribute("id", id, wr.SCOPE_REQUEST);	
			wr.setAttribute("size", size, wr.SCOPE_REQUEST);	
			wr.setAttribute("accountlist", accountlist, wr.SCOPE_REQUEST);
			List inter=gson.fromJson((String)otherUser.get("INTEREST"), List.class);
			wr.setAttribute("otherInter", inter, wr.SCOPE_REQUEST);
			
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
