package sns.club.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/club")
public class ClubChat {
	
	
	@RequestMapping("/all.do")
	public String clubAll() {
		
		return "club.chat.all";
	}

}
