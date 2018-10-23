package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoingDao {

	@Autowired
	SqlSessionTemplate template;
	
	//로그인
	public Map login(Map map) {
		return template.selectOne("account.login",map);
	}
}
