package sns.controller.account;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import sns.repository.BoardTestRepository;
import sns.repository.MyBoardDao;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	ServletContext svc;
	
	@Autowired
	MyBoardDao myboarddao;
	
	@Autowired
	BoardTestRepository btr;
	
	
	@GetMapping("/home.do")
	public String mypage(WebRequest wr) {
		List<Map> list = btr.findWriter("wlsgud1990");
		System.out.println(list);
		wr.setAttribute("list", list, WebRequest.SCOPE_SESSION);
		
		return "sns.mypage";
	}
	
	@PostMapping("/home.do")
	public String mypage(@RequestParam Map map, @RequestParam MultipartFile file) throws IllegalStateException, IOException {
		String realpath = svc.getRealPath("upload");
		System.out.println(realpath);
		File dir = new File(realpath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File insertfile = new File(dir,file.getOriginalFilename());
		file.transferTo(insertfile);
		
		String path = svc.getContextPath()+"/upload/"+file.getOriginalFilename();
		String type = file.getContentType();
		
		System.out.println("글작성버튼클릭후 받아온 RequestParam map : " + map);
		System.out.println(myboarddao.Myboard());
		map.put("_id", btr.getBoardNo());
		map.put("like", 0);
		map.put("writer", "shpbbb");
		map.put("file_attach", path);
		map.put("type", type.substring(0, 5));
		btr.insertOne(map);
		return "sns.mypage";
	}
	
	@RequestMapping("/write.do")
	public String write() {
		
		return "sns.write";
	}
	
	
	
}