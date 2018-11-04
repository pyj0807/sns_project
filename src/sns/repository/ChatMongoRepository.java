package sns.repository;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.CriteriaDefinition;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;


@Repository
public class ChatMongoRepository {
	
	@Autowired
	MongoTemplate template;
	@Autowired
	Gson gson;
	
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

public void roomupdate(String id1,String id2,String lasttime,String otherid,String cont) {
	Update u= new Update().set("lastsenddate", (long)(System.currentTimeMillis())).set("lastformat", lasttime).set("sendid",id1 ).set("cont", cont);
	template.updateMulti(new Query(Criteria.where("modeId").in(id1).andOperator(Criteria.where("modeId").in(id2))),u,"freechatroom");
	
}


public List<Map> getallroom(String id){
	return template.find(new Query(Criteria.where("modeId").in(id)), Map.class,"freechatroom");
	
}

public List<Map> getcount(String id){
	return template.find(new Query(Criteria.where("modeId").in(id)),Map.class,"freechatroom");
}

public void removecount(String id,String id2,String otherid) {
Update u= new Update().pull("readid", id);
	//template.updateMulti(new Query(Criteria.where("readid").in(id).and("otherId").in(id2).and("id").in(otherid)),u,"freechat");
	template.updateMulti(new Query(Criteria.where("readid").in(id).andOperator(Criteria.where("otherId").in(id2).andOperator(Criteria.where("id").in(otherid)))), u, "freechat");
}

/*
public String getcountt(String id) {//get카운트
	MongoClient client= MongoClients.create("mongodb://kzpray.mockingu.com:11111");	
	MongoDatabase db= client.getDatabase("project");	
	MongoCollection<Document> heroclt= db.getCollection("freechatroom");
	
	
	FindIterable<Document> i=heroclt.find(new Document(id,new Document("$exists",true)));
	Document doc=new Document();
	for(MongoCursor<Document> cu=i.iterator();cu.hasNext();) {
		doc=cu.next();
		System.out.println(doc.toJson());
	}

	return gson.toJson(doc);
}
*/


public void removecountsocket(String id) {
	template.remove(new Query(Criteria.where("readid").in(id)),"freechatroom");
}

public void roomcountupdate(String id,String otherid) { //채팅방 카운팅
	Update u =new Update().inc(otherid, 1);
template.updateMulti(new Query(Criteria.where("modeId").in(id).andOperator(Criteria.where("modeId").in(otherid))),u,"freechatroom");
}

public void roomcountupdatedown(String id,String otherid) { //채팅방 카운팅다운
	Update u =new Update().set(id, 0);
template.updateMulti(new Query(Criteria.where("modeId").in(id).andOperator(Criteria.where("modeId").in(otherid))),u,"freechatroom");
}







}
