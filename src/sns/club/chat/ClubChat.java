package sns.club.chat;

import java.io.File;
import java.io.IOException;
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

import sns.repository.ClubChatMongoDeleteRepository;
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
	
	@Autowired
	ClubChatMongoDeleteRepository mongoremove;
	
	@RequestMapping("/all.do")
	public String clubAll(ModelMap map) {
		TimeSorter sr= new TimeSorter();
		List<Map> li=clubmongo.getAllopenChat();
		
		li.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1= (long)o1.get("createdate");
				long n2= (long)o2.get("createdate");
				
				if(n1<n2) {
					return 1;
				}else if(n1>n2) {
					return -1;
				}else {
					return 0;
				}
			}
		});
		
		map.put("clubAll", li);
		return "club.chat.all";
	}
	
	
	@GetMapping("/create.do")
	public String clubcreate() {
		
		return "club.chat.create";
	}
	
	@PostMapping("/createon.do")
	public String clubcreateon(@RequestParam String info ,
			@RequestParam MultipartFile attach  , WebRequest wr) throws IllegalStateException, IOException{
	
		
			Map map=new LinkedHashMap<>();
			List human =new ArrayList<>();
		System.out.println(info);
		
		System.out.println(attach.getContentType());
		System.out.println("호호="+attach.getName());
		
		String filename= attach.getOriginalFilename();
		
		String id =(String)wr.getAttribute("Id", wr.SCOPE_SESSION);
		human.add(id);
		System.out.println(id);
		
		
		
		String[] str =attach.getContentType().split("/");
		
		System.out.println(str[0]);
		
		String path =ctx.getRealPath("clubimg");
		File dir = new File(path);
		System.out.println("꿀꿀꿀="+path);
		String constex=ctx.getContextPath();
		
		String ext ="."+ FilenameUtils.getExtension(filename);
		
		System.out.println(ext+"qwtgrehd");
		
		
			
			map.put("_id", info);
			map.put("mainid", id);
			map.put("attach", constex+"/clubimg/"+new Date(System.currentTimeMillis()).getTime()+ext);
			map.put("createdate", new Date(System.currentTimeMillis()).getTime());
			map.put("agency",human );
		
			long gg= new Date(System.currentTimeMillis()).getTime();
			File dst= new File(dir,gg+ext);
		if(str[0].equals("image")) {
		if(!dst.exists()) {
			dst.mkdirs();
		}
		
		
		
			System.out.println("저장될 경로="+dst.toString());
			clubmongo.createroom(map);
			attach.transferTo(dst);
			return "redirect:/club/all.do";
		
	
		
		}else {
			
			return "redirect:/club/create.do";
		}
		
		
	}
	
	
	
	@GetMapping("/clubview.do")
	public String clubchatview(ModelMap map,@RequestParam Map mapp,WebRequest wr) {
		String id =(String)wr.getAttribute("Id", wr.SCOPE_SESSION);
		String content =(String)mapp.get("id");
		/*System.out.println(id);*/
		
		
		
			if(clubmongo.getagencyChat(content, id).size()<1) {
				clubmongo.clubagency(content,id);
			}
		List li =clubmongo.getaAencyAllclub(id);
		
		 
		   
		
		System.out.println("깔갈깔="+clubmongo.clubbest(id,content));
		
		map.put("best", clubmongo.clubbest(id,content));
		map.put("contentid", content);
		map.put("clubchating", clubmongo.clubchatingview(content));
		map.put("allclub", li);
		return "club.chat.view";
	}
	
	
	@GetMapping("/remove.do")
	public String clubremoveroom(@RequestParam Map map,WebRequest wr) {
		System.out.println("이이이이="+(String)map.get("contentid")+(String) wr.getAttribute("Id", wr.SCOPE_SESSION));
		mongoremove.roomremove((String)map.get("contentid"),(String) wr.getAttribute("Id", wr.SCOPE_SESSION));
		mongoremove.roomchatremove((String)map.get("contentid"));
		return "redirect:/club/all.do";
	}
	
	
	
	
	

}
