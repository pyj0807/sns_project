package sns.controller.account;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import sns.repository.BoardRepository;
import sns.repository.FollowRepository;

@Controller
public class InterestContoller {
	@Autowired
	BoardRepository boardRepository;	
	@Autowired
	FollowRepository follow;
	
	@RequestMapping("/interest.do")
	public String interest(@RequestParam String theme, ModelMap modelmap){
		List<Map> list = boardRepository.getBoardTheme(theme);
		for(int i=0; i<list.size(); i++) {
			long writetime = (long)list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			list.get(i).put("lasttime", lasttime);
		}
		modelmap.put("theme", theme);
		modelmap.put("list", list);
		
		
		return "sns.theme";
	}
	
	@RequestMapping("/interestfeed.do")
	public String interestfeed(@RequestParam String theme, ModelMap modelmap,WebRequest wr){
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		List list = follow.getFollowingList(loginId);
		List<Map> tlist = boardRepository.getBoardTheme(theme);
		List<Map> mylist = new ArrayList<>();
		for(int i=0; i<mylist.size(); i++) {
			long writetime = (long)mylist.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			mylist.get(i).put("lasttime", lasttime);
		}
		for(int i=0; i<tlist.size(); i++) {
			if(list.contains(tlist.get(i).get("writer"))) {
				mylist.add(tlist.get(i));
			}
		}
		modelmap.put("theme", theme);
		modelmap.put("mylist", mylist);
		
		return "sns.theme.my";
		
	}
	
}
