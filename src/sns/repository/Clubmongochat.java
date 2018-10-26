package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;


@Repository
public class Clubmongochat {
	@Autowired
	MongoTemplate template;
	
	public boolean createroom(Map map) {
		try {	
		Map rst =template.insert(map,"clubroom");
		return rst != null;
	}catch (Exception e) {
		e.printStackTrace();
		return false;
	}
		
	}
	public List<Map> getAllopenChat() {
		return template.find(new Query(),Map.class, "clubroom");
	}
	
	
	
	public List<Map> getopenchat(String id,String content){
		
		return template.find(new Query(Criteria.where("agency").in(id).and("_id").in(content)), Map.class,"clubroom");
		
	}
	
}
	
	

