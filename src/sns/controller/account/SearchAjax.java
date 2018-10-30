package sns.controller.account;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import sns.repository.BoardDao;
import sns.repository.MongoHashTag;
import sns.repository.SearchDao;

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
		for(int i=0;i<list.size();i++) {
			System.out.println("후라이팬이름="+list.get(i).get("NAME"));
		}
		List li=boarddao.getAllBoard();
		List hashtag=new ArrayList<>();
		for(int i=0; i<li.size();i++) {
			Map mm=(Map)li.get(i);
			System.out.println(mm);
			List aa=(List)mm.get("hashcode");
			System.out.println(aa.toString());
			
		}
		
		
		return gson.toJson(list);
	}
	
}
