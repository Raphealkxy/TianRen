package com.action;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Kind;
import com.service.KindService;

public class KindAction extends ActionSupport implements ModelDriven<Kind>{

	private Kind kind=new Kind();
	
	public Kind getModel() {
		// TODO Auto-generated method stub
		return kind;
	}
	
	public void setKind(Kind kind) {
		this.kind = kind;
	}

	private KindService kindService;
	
	public void setKindService(KindService kindService) {
		this.kindService = kindService;
	}

	/**
	 * 添加影片类别
	 * @return
	 * @throws Exception
	 */
	public String saveKind() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		kind.setKindName(request.getParameter("kindName"));
		kindService.create(kind);
		Map<String,Object> appliction =ActionContext.getContext().getApplication();
		appliction.put("lstKind", kindService.findAll());
		return "saveMovie";
	}
}
