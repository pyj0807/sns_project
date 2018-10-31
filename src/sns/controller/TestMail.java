package sns.controller;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestMail {

	@Autowired
	JavaMailSender sender;
	
	@RequestMapping("/mail.do")
	public void sendTest() {
		SimpleMailMessage msg = new SimpleMailMessage();
		sender.createMimeMessage();
		msg.setSubject("메일 테스트");	//메일 제목임
		String txt = "인증키"; // 인증기
		txt += UUID.randomUUID().toString().split("-")[0];  //인증키 생성
		msg.setText(txt);
		msg.setTo("joon920807@hanmail.net");	// 받는사람
		msg.setFrom("aaa@hahah.com");
		
		try {
			sender.send(msg);
			System.out.println("성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("실패");
		}
	
	
	}
}
