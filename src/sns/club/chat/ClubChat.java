package sns.club.chat;

import java.io.File;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import sns.repository.Clubmongochat;

class TimeSorter implements Comparator<Integer> {

	
	public int compare(Integer a,Integer b) {
	return (Integer)(a-b);
	}
	
}

@Controller
@RequestMapping("/club")
public class ClubChat {
	
	
	@Autowired
	ServletContext ctx;
	
	@Autowired
	Clubmongochat clubmongo;
	
	
	
	@RequestMapping("/all.do")
	public String clubAll(ModelMap map) {
		TimeSorter sr= new TimeSorter();
		List<Map> li=clubmongo.getAllopenChat();
		for(int i=0;i<li.size();i++) {
		
		
		}
		
		map.put("clubAll", li);
		return "club.chat.all";
	}
	
	
	@GetMapping("/create.do")
	public String clubcreate() {
		
		return "club.chat.create";
	}
	
	@PostMapping("/createon.do")
	public String clubcreateon(@RequestParam String info ,
			@RequestParam MultipartFile attach  , WebRequest wr) {
	
		
			Map map=new LinkedHashMap<>();
			List human =new ArrayList<>();
		System.out.println(info);
		
		System.out.println(attach.getContentType());
		System.out.println("호호="+attach.getName());
		
		String filename= attach.getOriginalFilename();
		
		String id =(String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		human.add(id);
		System.out.println(id);
		
		
		
		String[] str =attach.getContentType().split("/");
		
		System.out.println(str[0]);
		
		String path =ctx.getRealPath("/clubimg/");
		File dst= new File(path,filename);
		System.out.println("경로(당)=" +path+filename);
		System.out.println("실제네임(김나윤)"+filename);
		
		String constex=ctx.getContextPath();
			System.out.println("불러올경로(경수대로 883번길 33. 107동 501호)="+constex+"/clubimg/"+filename);
			String ext ="."+ FilenameUtils.getExtension(filename);
			
			map.put("_id", info);
			map.put("mainid", id);
			map.put("attach", constex+"/clubimg/"+new Date(System.currentTimeMillis()).getTime()+ext);
			map.put("createdate", new Date(System.currentTimeMillis()).getTime());
			map.put("agency",human );
		
		if(str[0].equals("image")) {
		if(!dst.exists()) {
			dst.mkdirs();
		}
		
		try {
			
			clubmongo.createroom(map);
			attach.transferTo(dst);
			return "redirect:/club/all.do";
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:/club/create.do";
		}
		
		}else {
			
			return "redirect:/club/create.do";
		}
		
		
	}
	
	

}
