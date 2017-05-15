package com.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Edition;
import com.service.EditionService;

public class EditionAction extends ActionSupport implements ModelDriven<Edition>{

	private Edition edition=new Edition();
	
	public Edition getModel() {
		// TODO Auto-generated method stub
		return edition;
	}

	public void setEdition(Edition edition) {
		this.edition = edition;
	}

	private EditionService editionService;

	public void setEditionService(EditionService editionService) {
		this.editionService = editionService;
	}
	
	public String saveEdition() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		edition.setEditionName(request.getParameter("editionName"));
		editionService.create(edition);
		Map<String,Object> appliction =ActionContext.getContext().getApplication();
		appliction.put("lstEdition", editionService.findAll());
		return "saveMovie";		
	}
}
