package com.util;

import java.io.File;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

public class FileProcessUitl {
	
	public String processFileUpload( String path , File[] file , String[] fileName) {
		if(fileName==null){
			return null;
		}
		try {
			StringBuffer file_location = new StringBuffer();
			
			//获取保存到 tomcat 服务器上的绝对路径
			ServletContext context = ServletActionContext.getServletContext();
			
			for( int i = 0 ; i < file.length ; i++) {
				String targetDirectory =context.getRealPath(path).trim();    //   -->  C://program files /apache Fundation so ...../项目名/文件夹名
				
				String extName =fileName[i].substring(fileName[i].indexOf("."));
				
				String GenericFileName=System.nanoTime()+extName;
				
				//获取保存到数据库的相对路径字符串 . 类似于 : /项目名/upload/xxx.jpg
				String location = ServletActionContext.getRequest().getContextPath()+path+"/"+GenericFileName;
				
				//上传文件
				File target = new File( targetDirectory , GenericFileName );
				
				FileUtils.copyFile(file[i], target);
			
				file_location.append(location).append(",");
				
			}
			
			String locations = file_location.deleteCharAt(file_location.lastIndexOf(",")).toString();
			return locations;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
