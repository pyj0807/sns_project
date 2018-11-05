package sns.controller;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

@Controller
public class EmailController {
	
	@Autowired
	JavaMailSender sender;
	
	@ResponseBody
	@PostMapping("/email.do")
	public String emailsenderHandl(WebRequest wr,@RequestParam Map param) {
		SimpleMailMessage msg = new SimpleMailMessage();
		String email01 = (String)param.get("email01");
		String email02 = (String)param.get("email02");
		String receiver  = email01 + "@" + email02;
		System.out.println("email옴?");
		System.out.println(receiver);
		
		msg.setSubject("회원가입 인증번호");
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
			System.out.println("성공?");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("나가리");
		}
		return txt;
	}
	
	@ResponseBody
	@PostMapping("/emailauth.do")
	public String emailsenderHandle(@RequestParam Map param,WebRequest wr) {
		String confirm = (String)wr.getAttribute("confirm", wr.SCOPE_SESSION);
		String confirm1 = (String)param.get("confirmkey");
		String rst;
		System.out.println(confirm);
		System.out.println(confirm1);
		wr.removeAttribute("confirmKey", wr.SCOPE_SESSION);
		if(confirm.equals(confirm1)) {
			rst = "true";
			wr.setAttribute("rst", rst, wr.SCOPE_SESSION);
			System.out.println(rst);
			return rst;
		}else {
			rst = null;
			wr.setAttribute("rst", rst, WebRequest.SCOPE_SESSION);
			System.out.println(rst);
			return rst;
		}
		
	}
	
	
	
	
	
}
