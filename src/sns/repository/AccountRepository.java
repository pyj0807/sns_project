package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountRepository {
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	public Map getOneUserInfo(String email) {
		return sqltemplate.selectOne("account.getOneUserInfo", email);
	}
	
}
