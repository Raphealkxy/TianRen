package com.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Language;
import com.service.LanguageService;

public class LanguageAction extends ActionSupport implements ModelDriven<Language>{

	private Language language=new Language();
	
	public Language getModel() {
		// TODO Auto-generated method stub
		return language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}
	
	private LanguageService languageService;

	public void setLanguageService(LanguageService languageService) {
		this.languageService = languageService;
	}
	
	/**
	 * ÃÌº””∞∆¨”Ô—‘
	 * @return
	 * @throws Exception
	 */
	public String saveLanguage() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		language.setLanguageName(request.getParameter("languageName"));
		languageService.create(language);
		Map<String,Object> appliction =ActionContext.getContext().getApplication();
		appliction.put("lstLanguage", languageService.findAll());
		return "saveMovie";
	}
}
