package sns.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import sns.repository.JoinDao;
import sns.repository.LoginCheckDao;

@Controller
public class JoinController {

	@Autowired
	JoinDao jdao;

	@Autowired
	LoginCheckDao lcdao;

	@Autowired
	Gson gson;

	@GetMapping("/join.do")
	public String joinGetHandle(ModelMap map,@RequestParam Map param) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,애니,애견,기타,".split(",");
		map.put("interest", data);
		
		if(param.get("nojoin") != null) {
			map.put("nojoin", "on");
		}
		
		return "index/join";
	}

	@PostMapping("/join.do")
	public String joinPostHandle(@RequestParam Map param, ModelMap map, WebRequest wr) {

		String id = (String) param.get("id");
		String emailid = (String) param.get("email01");
		String subid = (String) param.get("email22");
		String email = emailid + "@" + subid;
		String pass = (String) param.get("pass");
		String name = (String) param.get("name");
		String question =(String)param.get("qeustion");
		String answer =(String)param.get("answer");
		
		String yy = (String) param.get("yy");
		String mm = (String) param.get("mm");
		String dd = (String) param.get("dd");
		String birth = yy + mm + dd;

		String gender = (String) param.get("gender");

		String[] interest = wr.getParameterValues("interest");
		String inter = Arrays.toString(interest);

		Map data = new HashMap<>();
		data.put("id", id);
		data.put("subid", subid);
		data.put("email", email);
		data.put("pass", pass);
		data.put("name", name);
		data.put("birth", birth);
		data.put("attach", "01.jpg");
		data.put("question",question);
		data.put("answer", answer);
		System.out.println("question>>>>"+question);
		System.out.println("answer>>>>>>"+answer);
		
		// data.put("day", day);

		data.put("gender", gender);
		data.put("interest", inter);
		System.out.println(data);

		try {
			int a = jdao.addAccount(data);

			return "redirect:/login.do";

		} catch (Exception e) {
			
			e.printStackTrace();
			
			return "redirect:/join.do?nojoin=no";
		}

	}

	@GetMapping(path = "/joinajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String joinajaxHandle(@RequestParam String id) {
		Map ckid = lcdao.loginCheck(id);
		Map map = new HashMap<>();
		if (ckid != null) {
			map.put("pass", "on");
		} else {
			map.put("pass", "off");
		}
		return gson.toJson(map);
	}

	@GetMapping(path = "/emailajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emailajaxHandle(@RequestParam String email) {
		Map ckemail = jdao.emailCheck(email);
		Map map = new HashMap<>();
		if (ckemail != null) {
			map.put("pass", "on");
		} else {
			map.put("pass", "off");
		}
		return gson.toJson(map);
	}

}
