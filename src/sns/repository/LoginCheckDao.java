package sns.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginCheckDao {
	
	@Autowired
	SqlSessionTemplate template;

	public Map loginCheck(String id){
		return template.selectOne("account.loginCheck",id);
	}
}

