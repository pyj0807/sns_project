package sns.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import sns.repository.ChangePassDao;

@Controller
public class ChangeController {
	
	@Autowired
	ChangePassDao cpdao;
	
	@GetMapping("/change.do")
	public String changeGetHandle(Map map) {
		
		
		return "index/changePass";
	}
	
	@PostMapping("/change.do")
	public String changePostHandle(@SessionAttribute Map user, @RequestParam Map map, ModelMap model) {
		String cp = (String)user.get("PASS");
		String op = (String)map.get("opass");

		if(op.equals(cp)) {
			map.put("id", user.get("ID"));
			int r = cpdao.changePass(map);
			if(r>0) {
				return "sns.mypage";
			}
		}
		return "index/changePass";
	}
	
}

