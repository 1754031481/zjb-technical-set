package com.jk.dao.poi;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.jk.model.Menu;

@Repository
public class PoiDaoImpl implements PoiDao {
	
	@Autowired
	@Qualifier("sqlMapClient")
	private SqlMapClient sqlMapClient;

	@Override
	public List<Menu> menuList(Menu menu) throws Exception {
		List<Menu> menuList = sqlMapClient.queryForList("Menu.menuList", menu);
		return menuList;
	}

	@Override
	public void insertMenu(List<Menu> list) throws Exception {
		sqlMapClient.insert("Menu.insertMenu", list);
	}
}
