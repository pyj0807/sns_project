package sns.controller;

import java.util.HashMap;
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

import sns.repository.AccountDao;
import sns.repository.ChangePassDao;

@Controller
public class FindIdPasscontroller {

	@Autowired
	AccountDao accdao;
	
	@Autowired
	Gson gson;
	
	@Autowired
	ChangePassDao passdao;
	
	
	
	@GetMapping("/find.do")
	public String findpass(@RequestParam Map mm,ModelMap model) {
		String id="";
		if(mm.get("realid")!=null) {
			id=(String)mm.get("realid");
		}
		model.put("realid", id);
		if(mm.get("CCCUE")!=null) {
			System.out.println("이게 모드다>>"+mm.get("CCCUE"));
			model.put("CCUE", "on");
		}
		
		return "index/find";
	}
	
	
	@ResponseBody
	@GetMapping(path="/findpassajax.do",produces="application/json;charset=utf-8")
	public String ajaxfind(@RequestParam String id) {
		Map map =accdao.accountselect(id);
		System.out.println(id);
		if(map!=null) {
			map.put("mode", "on");
			
			
		
			return gson.toJson(map);
		}else {
			Map mm=new HashMap<>();
			mm.put("mode", "off");
			return gson.toJson(mm);
			
		}
		
	}
	
	@GetMapping("/answer.do")
	public String asnwerHandle(@RequestParam Map mm,WebRequest wr,ModelMap model) {
		System.out.println("꾜로로>>"+(String)mm.get("answeridd"));
		Map map=accdao.accountselect((String)mm.get("answeridd"));
		
		if(map.get("ANSWER").equals(mm.get("answer"))) {
			
			return "redirect:/newchangepass.do?id="+(String)mm.get("answeridd");
		}else {
			model.put("CCCUE", "off");
			return "redirect:/find.do?modee=on";
		}
	}
	
	
	@GetMapping("/newchangepass.do")
	public String newchangepass(@RequestParam Map map,ModelMap model) {
		System.out.println("뀨??"+map.get("id"));
		model.put("mainid", map.get("id"));
		
		if(map.get("fail")!=null) {
			model.put("faill", "on");
		}
		return "index/fundnewcange";
	}
	
	
	@PostMapping("/newchangepass.do")
	public String newchangepasspost(@RequestParam Map map,ModelMap model) {
		String pass1 = (String)map.get("pass1");
		String npass = (String)map.get("pass2");
		String id= (String)map.get("findid");
		System.out.println(pass1+"////"+npass+"////"+id);
		if(pass1.equals(npass)) {
			Map m=new HashMap<>();
			m.put("id", id);
			m.put("npass", npass);
			int i=passdao.newchangepass(m);
			if(i==1)
				return "redirect:/login.do?newpass=on";
			
		}
			model.put("id", id);
			return "redirect:/newchangepass.do?fail=on";
		
		
		
		
	}
	
	
	
}
