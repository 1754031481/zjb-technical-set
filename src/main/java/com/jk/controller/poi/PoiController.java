package com.jk.controller.poi;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.jk.controller.BaseController;
import com.jk.controller.ztree.MenuController;
import com.jk.model.Menu;
import com.jk.service.poi.PoiService;
import com.jk.util.ExportExcel;
import com.jk.util.Json;
@Controller
@RequestMapping("poiController")
public class PoiController extends BaseController implements ServletContextAware{

//	日志记录
	private static final Logger logger=Logger.getLogger(PoiController.class);
	
	@Autowired
	private PoiService poiService; 
	private ServletContext servletContext;
	

	@RequestMapping("importExcel")
	public String importExcel(Menu menu,@RequestParam("file")  CommonsMultipartFile file, HttpServletResponse response){
		if (!file.isEmpty()) {
			// 获取本地存储路径
			String path = this.servletContext.getRealPath("/upload/");
			logger.info(path);
			String fileName = file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf("."));
			logger.info(fileType);
			String imgUrl = new Date().getTime() + fileType;
			File file2 = new File(path, imgUrl);
			try {
				// 将上传的文件写入到新建的文件中
				file.getFileItem().write(file2);
				//获得上传之后的文件具体路径
				String filePath = path + "\\" + imgUrl;
				List<Menu> list = new ArrayList<Menu>();
				//poi解析excel文件
				if (fileType.equals(".xls")) {
					HSSFWorkbook hw = new HSSFWorkbook(new FileInputStream(new File(filePath)));
					HSSFSheet sheet1 = hw.getSheetAt(0);
					for (int i = 0; i < hw.getNumberOfSheets(); i++) {
						HSSFSheet sheetAt = hw.getSheetAt(i);
						for (int j = 3; j < sheetAt.getPhysicalNumberOfRows(); j++) {
							HSSFRow row = sheetAt.getRow(j);
							Menu m = new Menu();
							m.setName(PoiController.getCellValue(row.getCell(1)));
							m.setIcon(PoiController.getCellValue(row.getCell(2)));
							m.setUrl(PoiController.getCellValue(row.getCell(3)));
							m.setTarget(PoiController.getCellValue(row.getCell(4)));
							list.add(m);
						}
					}
					//将菜单列表信息存入数据库
					poiService.insertMenu(list);
				} else if (fileType.equals(".xlsx")) {
					
				}
			} catch (Exception e) {
				
			}
			
		} else {
			
		}
		return "poi";
	}
	
	//判断从Excel文件中解析出来数据的格式   
    private static String getCellValue(HSSFCell cell){   
        String value = null;   
        //简单的查检列类型   
        switch(cell.getCellType())   
        {   
            case HSSFCell.CELL_TYPE_STRING://字符串   
                value = cell.getRichStringCellValue().getString();   
                break;   
            case HSSFCell.CELL_TYPE_NUMERIC://数字   
                long dd = (long)cell.getNumericCellValue();   
                value = dd+"";   
                break;   
            case HSSFCell.CELL_TYPE_BLANK:   
                value = "";   
                break;      
            case HSSFCell.CELL_TYPE_FORMULA:   
                value = String.valueOf(cell.getCellFormula());   
                break;   
            case HSSFCell.CELL_TYPE_BOOLEAN://boolean型值   
                value = String.valueOf(cell.getBooleanCellValue());   
                break;   
            case HSSFCell.CELL_TYPE_ERROR:   
                value = String.valueOf(cell.getErrorCellValue());   
                break;   
            default:   
                break;   
        }   
         return value;   
     }  
	
	@RequestMapping("exportPoiMenu")
	public void exportPoiMenu(Menu menu,HttpServletResponse response){
		String title="菜单管理";
		String[] rowName=new String[]{"序号", "名称", "图标", "路径", "展开方式"};
		List<Object[]> dataList=new ArrayList<>();
		List<Menu> menuList=null;
		try {
			menuList = poiService.menuList(menu);
			for (Menu menu2 : menuList) {
				Object[] obj=new Object[rowName.length];
				obj[0] = menu2.getId();
				obj[1] = menu2.getName();
				obj[2] = menu2.getIcon();
				obj[3] = menu2.getUrl();
				obj[4] = menu2.getTarget();
				dataList.add(obj);
			}
			ExportExcel exportExcel = new ExportExcel(title, rowName, dataList, response);
			exportExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
/**
 * <pre>showListPoi(动态查询poi)   
 */
	@RequestMapping("showListPoi")
	public void showListPoi(Menu menu,HttpServletResponse response){
		Json j=new Json();
		try {
			List<Menu>	menuList=poiService.menuList(menu);
			j.setSuccess(true);
			j.setObject(menuList);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("系统错误，请联系管理员");
		}
		super.writeJson(j, response);
	}
	/**
	 * <pre>exportExcel(动态导出poi)   
	 */
	@RequestMapping("exportExcel")
	public void exportExcel(Menu menu,String checks,HttpServletResponse response){
		try {
			String chs=new String(checks.getBytes("ISO-8859-1"),"UTF-8");
			String title="菜单管理";
			String[] rowName = chs.split(",");
			List<Object[]> dataList=new ArrayList<>();
			List<Menu> menuList = poiService.menuList(menu);
			for (Menu menu2 : menuList) {
				Object[] obj = new Object[rowName.length];
				for (int i = 0; i < rowName.length; i++) {
					if (rowName[i].trim().equals("序号")) {
						obj[i] = menu2.getId();
					}
					if (rowName[i].trim().equals("名称")) {
						obj[i] = menu2.getName();
					}
					if (rowName[i].trim().equals("图标")) {
						obj[i] = menu2.getIcon();
					}
					if (rowName[i].trim().equals("路径")) {
						obj[i] = menu2.getUrl();
					}
					if (rowName[i].trim().equals("展开方式")) {
						obj[i] = menu2.getTarget();
					}
				}
				dataList.add(obj);
			}
			ExportExcel exportExcel=new ExportExcel(title, rowName, dataList, response);
			exportExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	
	

}
