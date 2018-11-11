package sns.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import sns.repository.AccountDao;
import sns.repository.JoinDao;

@Controller
public class FindIdController {
	
	@Autowired
	JoinDao jdao;
	@Autowired
	Gson gson;
	@Autowired
	JavaMailSender sender;
	@Autowired
	AccountDao accdao;
	
	
	
	@GetMapping("/findid.do")
	public String findIdGetHandle() {
		
		return "index/findid";
	}
	
	@ResponseBody
	@PostMapping("/findid.do")
	public String findIdHandle(@RequestParam Map param, WebRequest wr) {
		SimpleMailMessage msg = new SimpleMailMessage();
		System.out.println(param);
		System.out.println("옴");
		String email01 = (String) param.get("email11");
		String email02 = (String) param.get("email22");
		String receiver = email01 + "@" + email02;
		
		System.out.println(receiver);
		msg.setSubject("아이디찾기 인증번호");
		String txt = "인증번호 : ";
		String confirm = UUID.randomUUID().toString().split("-")[0];
		txt += confirm;
		wr.setAttribute("confirm", confirm, wr.SCOPE_SESSION);
		msg.setText(txt);
		msg.setTo(receiver);
		msg.setFrom("sns@test.com");
		System.out.println(txt);
		try {
			sender.send(msg);
			System.out.println("성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("나가리");
		}
		return txt;
	}
	
	
	@GetMapping(path = "/idemailajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emailajaxHandle(@RequestParam String email) {
		Map map = new HashMap<>();
		if (jdao.emailCheck(email) != null) {
			Map ckemail = jdao.emailCheck(email);
			map.put("pass", "on");
			String id = (String)ckemail.get("ID");
			map.put("id", id);
			System.out.println(ckemail);
			System.out.println(id);
			return gson.toJson(map);
		} else {
			map.put("pass", "off");
			return gson.toJson(map);
		}
	}

	
	@ResponseBody
	@PostMapping("/idemailauth.do")
	public String emailsenderHandle(@RequestParam Map param, WebRequest wr) {
		String confirm = (String) wr.getAttribute("confirm", wr.SCOPE_SESSION);
		String confirm1 = (String) param.get("confirmkey");
		String rst;
		wr.removeAttribute("confirmKey", wr.SCOPE_SESSION);
		System.out.println("오냐?");
		if (confirm.equals(confirm1)) {
			rst = "true";
			wr.setAttribute("rst", rst, wr.SCOPE_SESSION);
			return rst;
		} else {
			rst = null;
			wr.setAttribute("rst", rst, wr.SCOPE_SESSION);
			return rst;
		}

	}
	

	
}
