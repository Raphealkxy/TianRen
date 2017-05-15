package com.action;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Ad;
import com.service.AdService;
import com.util.FileProcessUitl;

public class AdAction extends ActionSupport implements ModelDriven<Ad>{

	private Ad ad=new Ad();
	
	public Ad getModel() {
		// TODO Auto-generated method stub
		return ad;
	}
	
	private AdService adService=new AdService();

	public void setAdService(AdService adService) {
		this.adService = adService;
	}
	
	private File[] upload; // 代表上传的文件本身 ---> 图片A本身 图片B本身
	private String[] uploadContentType; // 代表文件类型 ---> png jpg
	private String[] uploadFileName; // 代表文件名 ---> A.PNG B.jpg

	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	/**
	 * 查询所用广告
	 * @return
	 * @throws Exception
	 */
	public String findAllAd() throws Exception{
		Map<String,Object> application=ActionContext.getContext().getApplication();
		List<Ad> lstAd= adService.findAll();
		application.put("lstAd", lstAd);
		return "updateAd";
	}
	
	/**
	 * 修改广告
	 * @return
	 * @throws Exception
	 */
	public String modifyAd() throws Exception{
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadAd", upload, uploadFileName);
		ad.setAdImg(path);
		adService.modify(ad);
		
		return findAllAd();
	}

}
