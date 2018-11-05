package sns.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.request.WebRequest;

import com.sun.java.swing.plaf.windows.resources.windows;

import sns.repository.ChangePassDao;

@Controller
public class ChangeController {
	
	@Autowired
	ChangePassDao cpdao;
	
	@GetMapping("/change.do")
	public String changeGetHandle(Map map) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,애니,애견,기타,".split(",");
		map.put("interest", data);
		
		return "index/changePass";
	}
	
	@PostMapping("/change.do")
	public String changePostHandle(@SessionAttribute Map user, @RequestParam Map map, WebRequest wr) {
		System.out.println(user);
		
		String cp = (String)user.get("PASS");
		String op = (String)map.get("opass");
		String np = (String)map.get("npass");
		String[] inter = wr.getParameterValues("interest");
		String interest = Arrays.toString(inter);
		System.out.println(cp +"/"+op+"/"+np+"/"+interest);
		
	
		Map passmap = new HashMap<>();
		passmap.put("id", user.get("ID"));
		passmap.put("npass", np);
		passmap.put("interest", interest);
		if(op.equals(cp)) {
			int r = cpdao.changePass(passmap);
			
			if(r>0) {
				
				return "sns.mypage";
			}
		}
		return "index/changePass";
	}
	
}

