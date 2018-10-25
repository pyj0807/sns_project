package sns.club.chat;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/club")
public class ClubChat {
	
	
	@Autowired
	ServletContext ctx;
	
	
	
	
	
	@RequestMapping("/all.do")
	public String clubAll(ModelMap map) {
		
		
		
		return "club.chat.all";
	}
	
	
	@GetMapping("/create.do")
	public String clubcreate() {
		
		return "club.chat.create";
	}
	
	@PostMapping("/createon.do")
	public String clubcreateon(@RequestParam String info ,
			@RequestParam MultipartFile attach ) {
	
		System.out.println(info);
		
		System.out.println(attach.getContentType());
		System.out.println(attach.getName());
		String filename= attach.getOriginalFilename();
		String[] str =attach.getContentType().split("/");
		System.out.println(str[0]);
		
		String path =ctx.getRealPath("/clubimg/");
		File dst= new File(path,filename);
		
		if(!dst.exists()) {
			dst.mkdirs();
		}
		
		try {
			
			attach.transferTo(dst);
			return "redirect:/club/all.do";
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:/club/create.do";
		}
		
		
	}
	
	

}
