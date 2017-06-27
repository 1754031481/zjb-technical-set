package com.jk.service.poi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.dao.poi.PoiDao;
import com.jk.model.Menu;

@Service
public class PoiServiceImpl implements PoiService {
	
	@Autowired
	private PoiDao poiDao;

	@Override
	public List<Menu> menuList(Menu menu) throws Exception {
		return poiDao.menuList(menu);
	}

	@Override
	public void insertMenu(List<Menu> list) throws Exception {
		poiDao.insertMenu(list);
	}

}
