package sns.repository;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
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

public boolean insertchatroom(Map map){
	try {
	Map rst =template.insert(map,"freechatroom");
	
	return rst!=null;
	}catch(Exception e){
		e.printStackTrace();
		return false;
	}
}

public List<Map> chatroomcheck(String id,String id2){
	
	List<Map> list2=template.find(new Query(Criteria.where("modeId").in(id).andOperator(Criteria.where("modeId").in(id2))),Map.class,"freechatroom");
	return list2;
	
}

public void roomupdate(String id1,String id2) {
	Update u= new Update().set("lastsenddate", (long)(System.currentTimeMillis())).addToSet("lastformat", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(System.currentTimeMillis()));
	template.updateMulti(new Query(Criteria.where("modeId").in(id1).andOperator(Criteria.where("modeId").in(id2))),u,"freechatroom");
	
}


public List<Map> getallroom(String id){
	return template.find(new Query(Criteria.where("modeId").in(id)), Map.class,"freechatroom");
	
}
}
