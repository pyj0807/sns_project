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
	
	public boolean insertfreechat(Map map,String id,String otherid) {
			Map mapp =template.insert(map);
					
		return mapp!=null;
	}
	
public List<Map> getfreechat(String id){
		
		List<Map> list2=template.find(new Query(Criteria.where("userId").in(id)),Map.class,"freechat");
		return list2;
		
	}

}
