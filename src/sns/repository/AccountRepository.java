package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountRepository {
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	// 다른 회원의 정보 Map 으로 뽑아오기
	public Map getOneUserInfo(String id) {
		return sqltemplate.selectOne("account.getOneUserInfo", id);
	}
	
}
