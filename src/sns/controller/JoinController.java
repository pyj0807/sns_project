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
	public String joinGetHandle(ModelMap map) {
		String[] data = "게임,운동,영화,음악,IT,<br/>연애,음식,여행,패션,기타".split(",");
		map.put("interest", data);

		return "index/join";
	}

	@PostMapping("/join.do")
	public String joinPostHandle(@RequestParam Map param, ModelMap map, WebRequest wr) {

		String id = (String) param.get("id");
		String subid = (String) param.get("subid");
		String email = id + "@" + subid;
		String pass = (String) param.get("pass");
		String name = (String) param.get("name");

		String yy = (String) param.get("yy");
		String mm = (String) param.get("mm");
		String dd = (String) param.get("dd");
		String birth = yy + mm + dd;
		
		
		//Date day = Date.valueOf(birth); 
				
		String gender = (String) param.get("gender");

		String[] interest = wr.getParameterValues("interest");
		System.out.println("관심사 : " + Arrays.toString(interest));
		String inter = Arrays.toString(interest);
		
		System.out.println(
				id + "/" + subid + "/" + email + "/" + pass + "/" + birth + "/" + name + "/" + gender + "/" + interest);

		Map data = new HashMap<>();
		data.put("id", id);
		data.put("subid", subid);
		data.put("email", email);
		data.put("pass", pass);
		data.put("name", name);
		data.put("birth", birth);
		//data.put("day", day);

		data.put("gender", gender);
		data.put("interest", inter);

		int a = jdao.addAccount(data);

		return "index/login";
	}
	
	
	@GetMapping(path="/joinajax.do", produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String joinajaxHandle(@RequestParam String email) {
		System.out.println(email);
		Map id = lcdao.loginCheck(email);
		System.out.println("id :"+id);
		Map map = new HashMap<>();
		if(id != null) {
			map.put("pass", "on");
			System.out.println(id +"사용중인 아이디");
		}else {
			map.put("pass", "off");
			System.out.println(id+"사용가능한 아이디");
		}
		return gson.toJson(map);
	}
	
	
	
	
	
	
}
