package sns.controller;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.socket.TextMessage;

import sns.repository.AccountDao;
import sns.repository.AlertService;
import sns.repository.FollowLikemongoalert;

@Controller
public class NavAlertcontroller {
	
	@Autowired
	AccountDao acdao;
	@Autowired
	FollowLikemongoalert mongoalert;
	@Autowired
	AlertService service;
	@Autowired
	FollowLikemongoalert follolikemongo;
	
	@ResponseBody
	@GetMapping("/navalert.do")
	public String removeAlert(@RequestParam Map map,WebRequest wr) {
		
		mongoalert.updatemongofollowlike((String)wr.getAttribute("Id",wr.SCOPE_SESSION));
		List<Map> qq=follolikemongo.mongofollowserviceall((String)wr.getAttribute("Id",wr.SCOPE_SESSION));
		String aaa="";
		qq.sort(new Comparator<Map>() {
	         @Override
	         public int compare(Map o1, Map o2) {
	            long n1= (long)o1.get("senddate");
	            long n2= (long)o2.get("senddate");
	            
	            if(n1<n2) {
	               return 1;
	            }else if(n1>n2) {
	               return -1;
	            }else {
	               return 0;
	            }
	         }
	      });
	
		Map alertMap=new HashMap<>();
		alertMap.put("mode", "defaultalertremov");
		alertMap.put("str", qq);
		
		
		service.sendOne(alertMap, (String)wr.getAttribute("Id",wr.SCOPE_SESSION));
	return "gg";
	}
	
}
