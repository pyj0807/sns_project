package sns.controller.account;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	FollowRepository foll;
	
	
	@RequestMapping("/account.do")
	public String account(WebRequest wr,@RequestParam String id) {
		List<Map> accountlist = boardRepository.findWriter(id);
		wr.setAttribute("id", id, wr.SCOPE_REQUEST);
		wr.setAttribute("accountlist", accountlist , WebRequest.SCOPE_SESSION);
		
		
		return "sns.account";
	}
	
	
	@ResponseBody
	@PostMapping("/follow.do")
	public String follow(@RequestParam Map map) {
		
		
		String myid =(String)map.get("myid");
		String otherid=(String)map.get("otherid");
		
		System.out.println("하하하하하핳"+myid);
		
		int r=foll.insertFollowing(map);
		int a=foll.insertFollower(map);
		if(r!=1) {
			foll.delFollowing(myid);
			foll.delFollower(otherid);
			return "{\"mode\":\"err\"}";
			
		}else {
			return "{\"mode\":\"on\"}";
		}
		
		
	}
	
	
}
