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
		String ss= "#";
		Pattern p = Pattern.compile(ss);
		Matcher mmmm= p.matcher((String)map.get("value"));
		String data="#원피스";
		String tag="#";
		Pattern q=Pattern.compile("#");
		Pattern qq=Pattern.compile((String)map.get("value"));
		Matcher m = q.matcher((String)map.get("value")); 
		/*System.out.println("트루인가 거짓인가?"+m.find());*/
		
		System.out.println("사이즈="+ss.length());
		List li=boarddao.getAllBoard();
		List hashtag=new ArrayList<>();
	
		
		
			if(mmmm.find()==false) {
				System.out.println("여기서부터가 #이 없을때");
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
			}else {
				System.out.println("여기서부터가 #이 있을때");
		if(((String)map.get("value")).length()>1) {
				for(int i=0; i<li.size();i++) {
					Map mm=(Map)li.get(i);
					/*System.out.println(mm);*/
					List aa=(List)mm.get("hashcode");
					for(int ii=0;ii<aa.size();ii++) {
						String str=(String)aa.get(ii);
					
						
						Matcher e=qq.matcher(str);
						if(e.find()==true) {
						if(!hashtag.contains((String)aa.get(ii))) {
							hashtag.add(aa.get(ii));
						}
						}
					}
						
				}
		}
			}
		
			
	
				
			hashtag.sort(new AscendingString());
			
			Map allmap=new HashMap<>();
			allmap.put("idlist", list);
			allmap.put("taglist", hashtag);
			
			return gson.toJson(allmap);
				}
			
			
			
		
	
	
}

