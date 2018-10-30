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
	
	@PostMapping("/email.do")
	public void emailsenderHandl(WebRequest wr) {
		SimpleMailMessage msg = new SimpleMailMessage();
		String email01 = (String) wr.getParameter("email01");
		String email02 = (String) wr.getParameter("email02");
		String email = email01 + "@" + email02;
		System.out.println(email);
		
		msg.setSubject("회원가입 인증번호");
		String txt = "인증번호 : ";
		String confirm = UUID.randomUUID().toString().split("-")[0];
		
		
		wr.setAttribute("confirm", confirm, wr.SCOPE_SESSION);
		msg.setText(txt);
		msg.setTo(email);
		msg.setFrom("sns@test.com");
		
		try {
			sender.send(msg);
			System.out.println("성공?");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("나가리");
		}
		
	}
	
	@ResponseBody
	@RequestMapping("emailauth.do")
	public String emailsenderHandle(@RequestParam Map param,WebRequest wr) {
		String confirm = (String)wr.getAttribute("confirmKey", wr.SCOPE_SESSION);
		String confirm1 = (String)param.get("confirmkey");
		String rst;
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
