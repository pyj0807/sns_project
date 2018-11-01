package sns.controller.account;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import sns.repository.BoardRepository;
import sns.repository.FollowRepository;

@Controller
public class AccountController {
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	FollowRepository follow;
	@Autowired
	Gson gson;
	
	// 다른 회원 페이지
	@RequestMapping("/account.do")
	public String account(WebRequest wr, @RequestParam String id,ModelMap map) {

		System.out.println("진짜아이디유"+id);
		String sss="#";
		String[] str=new String[10]; 
		str[0]="%23"+id.substring(1);
		System.out.println(str);
		Pattern p = Pattern.compile(sss);
		Matcher d=p.matcher(id);
		if(d.find()==true) {
			
						
			wr.setAttribute("hashtag", str, wr.SCOPE_REQUEST);
			return "redirect:/board/board_search.do?hashtag="+str[0];
		}else {
		


		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		
		if (id.equals(loginId)) {
			// 파라미터값 id와 로그인한 id가 같으면 마이페이지로 리다이렉트
			return "redirect:/mypage.do";
		} else {
			// 다른 회원이 쓴 글목록 리스트와 사이즈(글개수)
			List<Map> accountlist = boardRepository.findWriter(id);
			for(int i=0; i<accountlist.size(); i++) {
				long writetime = (long)accountlist.get(i).get("time");
				long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
				accountlist.get(i).put("lasttime", lasttime);
			}
			int size = accountlist.size();
			Map otherUser = boardRepository.getOneUserInfo(id);
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
	
	// 뉴스피드 (팔로잉한 사람들의 글 목록)
	@RequestMapping("/newsfeed.do")
	public String newsfeed(WebRequest wr, ModelMap modelmap) {
		// 내가 팔로우 한 사람들의 목록을 뽑아서 그사람들의 글을 각각 리스트에 뽑아와서 한번에 뭉쳐서 소팅
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		// 내가 팔로우 한 사람들의 아이디 목록을 리스트에 넣었다.
		List list = follow.getFollowingList(loginId);
		// 새로운 리스트를 만들어서 여기에 그 사람들의 글을 전부 넣을거다. (이미 Repository에서 소팅하고옴)
		List<Map> allList = boardRepository.getFollowBoardCnt(list);
		for(int i=0; i<allList.size(); i++) {
			long writetime = (long)allList.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			allList.get(i).put("lasttime", lasttime);
		}
		wr.setAttribute("allList",	allList, wr.SCOPE_SESSION);
		
		String[] interest = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		String sInter = Arrays.toString(interest);
		List listInter = gson.fromJson(sInter, List.class);
		wr.setAttribute("allInter", listInter, wr.SCOPE_REQUEST);
		
		return "sns.newsfeed";
	}
	
	@RequestMapping("/alluser.do")
	public String alluser(WebRequest wr) {
		List<Map> list = follow.getAll();
		wr.setAttribute("list", list, wr.SCOPE_REQUEST);
		return "sns.alluser";
	}
	
}
