package com.jk.service.poi;

import java.util.List;

import com.jk.model.Menu;

public interface PoiService {

	List<Menu> menuList(Menu menu) throws Exception;

	void insertMenu(List<Menu> list) throws Exception;


}
