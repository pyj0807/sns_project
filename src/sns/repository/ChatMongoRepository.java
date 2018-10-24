package sns.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;


@Repository
public class ChatMongoRepository {
	
	@Autowired
	MongoTemplate template;
	
	public boolean insertfreechat(Map map) {
				try {	
					Map rst =template.insert(map,"freechat");
			return rst != null;
	}catch (Exception e) {
		e.printStackTrace();
		return false;
	}
	}
	
public List<Map> getfreechat(String id,String id2){
		
		List<Map> list2=template.find(new Query(Criteria.where("modeId").in(id).andOperator(Criteria.where("modeId").in(id2))),Map.class,"freechat");
		return list2;
		
	}

}
