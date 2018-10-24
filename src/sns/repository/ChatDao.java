package sns.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ChatDao {

	@Autowired
	SqlSessionFactory factory;
	
	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> chatgetall(){
		
		return template.selectList("snschat.chatgetall");
	}
}
