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
	public String joinGetHandle(ModelMap map) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,애니,애견,기타,".split(",");
		map.put("interest", data);

		return "index/join";
	}

	@PostMapping("/join.do")
	public String joinPostHandle(@RequestParam Map param, ModelMap map, WebRequest wr) {

		String id = (String) param.get("id");
		String emailid = (String)param.get("email01");
		String subid = (String) param.get("email22");
		String email = emailid + "@" + subid;
		String pass = (String) param.get("pass");
		String name = (String) param.get("name");

		String yy = (String) param.get("yy");
		String mm = (String) param.get("mm");
		String dd = (String) param.get("dd");
		String birth = yy + mm + dd;
		
				
		String gender = (String) param.get("gender");

		String[] interest = wr.getParameterValues("interest");
		System.out.println("관심사 : " + Arrays.toString(interest));
		String inter = Arrays.toString(interest);
		
		System.out.println(
				id + "/" + subid + "/" + email + "/" + pass + "/" + birth + "/" + name + "/" + gender + "/" + inter);

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

		
		try {
			int a = jdao.addAccount(data);
			
		
				return "redirect:/index.do";
			
			
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:/join.do";
		}

	}
	
	
	@GetMapping(path="/joinajax.do", produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String joinajaxHandle(@RequestParam String id) {
		System.out.println(id);
		Map ckid = lcdao.loginCheck(id);
		System.out.println("id :"+id);
		Map map = new HashMap<>();
		if(ckid != null) {
			map.put("pass", "on");
			System.out.println(id +"사용중인 아이디");
		}else {
			map.put("pass", "off");
			System.out.println(id+"사용가능한 아이디");
		}
		return gson.toJson(map);
	}
	
	@GetMapping(path="/emailajax.do", produces="application/json;charset=UTF-8" )
	@ResponseBody
	public String emailajaxHandle(@RequestParam String email) {
		System.out.println(email);
		Map ckemail = jdao.emailCheck(email);
		System.out.println("email : "+email);
		Map map = new HashMap<>();
		if(ckemail != null) {
			map.put("pass", "on");
			System.out.println("이미 인증을 한 이메일입니다. \n다른 이메일로 인증을 해주세요");
		}else {
			map.put("pass", "off");
			System.out.println("인증 가능한 이메일 입니다");
		}
		return gson.toJson(map);
	}
	
	
}


























