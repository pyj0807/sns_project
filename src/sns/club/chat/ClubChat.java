package sns.club.chat;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
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

	public int compare(Integer a, Integer b) {
		return (Integer) (a - b);
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
	public String clubAll(ModelMap map, WebRequest wr) {
		TimeSorter sr = new TimeSorter();
		List<Map> li = clubmongo.getAllopenChat();

		li.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("createdate");
				long n2 = (long) o2.get("createdate");

				if (n1 < n2) {
					return 1;
				} else if (n1 > n2) {
					return -1;
				} else {
					return 0;
				}
			}
		});

		map.put("clubAll", li);
		return "club.chat.all";
	}

	@GetMapping("/create.do")
	public String clubcreate(@RequestParam Map map,ModelMap model) {
		if(map.get("length")!=null) {
			model.put("length", "on");
		}
		if(map.get("notnull")!=null) {
			model.put("notnull", "on");
		}
		
		if(map.get("attachnull")!=null) {
			model.put("attachnull", "on");
		}
		
		

		return "club.chat.create";
	}

	@PostMapping("/createon.do")
	public String clubcreateon(@RequestParam String info, @RequestParam MultipartFile attach, WebRequest wr)
			throws IllegalStateException, IOException {

		
		if(info.length()<1) {
			return "redirect:/club/create.do?length=on";
		}
		List<Map> lll=clubmongo.getAllclub(info);
		for(int i=0; i<lll.size();i++) {
			System.out.println(lll.get(i).get("_id")+" 뀨?");
			if(lll.get(i).get("_id").equals(info)) {
				return "redirect:/club/create.do?notnull=on";
			}
		}
		
		if(attach.getSize()<10) {
			return "redirect:/club/create.do?attachnull=on";
		}
		
		
		
		
		Map map = new LinkedHashMap<>();
		List human = new ArrayList<>();

		String filename = attach.getOriginalFilename();
		String id = (String) wr.getAttribute("Id", wr.SCOPE_SESSION);
		human.add(id);

		String[] str = attach.getContentType().split("/");

		String path = ctx.getRealPath("clubimg");
		File dir = new File(path);
		String constex = ctx.getContextPath();

		String ext = "." + FilenameUtils.getExtension(filename);

		wr.setAttribute("cluballon", "on", wr.SCOPE_REQUEST);

		map.put("_id", info);
		map.put("mainid", id);
		map.put("attach", constex + "/clubimg/" + new Date(System.currentTimeMillis()).getTime() + ext);
		map.put("createdate", new Date(System.currentTimeMillis()).getTime());
		map.put("agency", human);

		long gg = new Date(System.currentTimeMillis()).getTime();
		File dst = new File(dir, gg + ext);
		if (str[0].equals("image")) {
			if (!dst.exists()) {
				dst.mkdirs();
			}
			clubmongo.createroom(map);
			attach.transferTo(dst);
			return "redirect:/chat/freechat.do?cluballon=on";
		} else {

			return "redirect:/club/create.do";
		}

	}

	@GetMapping("/clubview.do")
	public String clubchatview(ModelMap map, @RequestParam Map mapp, WebRequest wr) {
		String id = (String) wr.getAttribute("Id", wr.SCOPE_SESSION);
		String content = (String) mapp.get("id");// 방제목

		Map listmain = mongoremove.rommmainid(content);

		if (clubmongo.getagencyChat(content, id).size() < 1) {
			clubmongo.clubagency(content, id);
		}
		List<Map> li = clubmongo.getaAencyAllclub(id);

		String str = (String) listmain.get("mainid");

		map.put("best", clubmongo.clubbest(id, content));
		map.put("contentid", content);
		map.put("clubchating", clubmongo.clubchatingview(content));
		map.put("allclub", li);
		map.put("roommainid", str);
		return "club.chat.view";
	}

	@GetMapping("/remove.do")
	public String clubremoveroom(@RequestParam Map map, WebRequest wr) {
		mongoremove.roomremove((String) map.get("contentid"), (String) wr.getAttribute("Id", wr.SCOPE_SESSION));
		mongoremove.roomchatremove((String) map.get("contentid"));
		wr.setAttribute("cluballon", "on", wr.SCOPE_REQUEST);
		return "redirect:/chat/freechat.do?cluballon=on";
	}

	@GetMapping("/removeroomagency.do")
	public String agencyremove(@RequestParam Map map, WebRequest wr) {
		mongoremove.removeid((String) map.get("contentid"), (String) wr.getAttribute("userId", wr.SCOPE_SESSION));
		return "redirect:/chat/freechat.do?cluballon=on";
	}

	@GetMapping("/myallclub.do") // 내 오픈채팅방들
	public String myallclub(ModelMap map, WebRequest wr) {

		List<Map> li = clubmongo.clubmyall((String) wr.getAttribute("userId", wr.SCOPE_SESSION));
		li.sort(new Comparator<Map>() {
			@Override
			public int compare(Map o1, Map o2) {
				long n1 = (long) o1.get("createdate");
				long n2 = (long) o2.get("createdate");

				if (n1 < n2) {
					return 1;
				} else if (n1 > n2) {
					return -1;
				} else {
					return 0;
				}
			}
		});
		map.put("clubmyAll", li);
		return "club.myAll";

	}

}
