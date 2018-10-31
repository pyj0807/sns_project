package sns.controller.account;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import sns.repository.BoardDao;
import sns.repository.MongoHashTag;
import sns.repository.SearchDao;

class AscendingString implements Comparator<String> { 
	
	@Override 
	public int compare(String a, String b) { 
		return a.compareTo(b); 
	
	}
}



@Controller
public class SearchAjax {

	
		@Autowired
		Gson gson;
		@Autowired
		SearchDao dao;
		
		@Autowired
		BoardDao boarddao;
	
		
	@PostMapping(path="/searchAjax.do",produces="application/json;charset=UTF-8" )
/*		@PostMapping("/searchAjax.do" )*/
	@ResponseBody
	public String searchAjax(@RequestParam Map map) {
		System.out.println(map.get("value"));
		List<Map> list =dao.Allaccount((String)map.get("value"));
	/*	String regmove="#"+(String)map.get("value");
		String reg="[#원피스]";
		System.out.println("리젝스 확인용");
		System.out.println(regmove.matches(reg));
		System.out.println("리젝스 확인 끝");*/
		String ss= "#"+(String)map.get("value");
		Pattern p = Pattern.compile(ss);
		String data="#원피스";
		
		Matcher m = p.matcher(data); 
		/*System.out.println(m.find());*/
		/*for(int i=0;i<list.size();i++) {
			System.out.println("후라이팬이름="+list.get(i).get("NAME"));
		}*/
		System.out.println("사이즈="+ss.length());
		List li=boarddao.getAllBoard();
		List hashtag=new ArrayList<>();
		if(ss.length()>1) {
		for(int i=0; i<li.size();i++) {
			Map mm=(Map)li.get(i);
			/*System.out.println(mm);*/
			List aa=(List)mm.get("hashcode");
			for(int ii=0;ii<aa.size();ii++) {
				String str=(String)aa.get(ii);
				Matcher d=p.matcher(str);
			
				if(d.find()==true) {
				if(!hashtag.contains((String)aa.get(ii))) {
					hashtag.add(aa.get(ii));
				}
				}
			}
				
			}
			
		}
	hashtag.sort(new AscendingString());
		System.out.println(hashtag);
		Map allmap=new HashMap<>();
		allmap.put("idlist", list);
		allmap.put("taglist", hashtag);
		
		return gson.toJson(allmap);
	}
	
}
