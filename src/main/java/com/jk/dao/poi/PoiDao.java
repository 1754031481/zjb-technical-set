package com.jk.dao.poi;

import java.util.List;

import com.jk.model.Menu;

public interface PoiDao {

	List<Menu> menuList(Menu menu) throws Exception;

	void insertMenu(List<Menu> list) throws Exception;

}
