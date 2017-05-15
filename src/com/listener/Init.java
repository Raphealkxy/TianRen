package com.listener;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.ContextStartedEvent;
import org.springframework.context.event.ContextStoppedEvent;

import com.opensymphony.xwork2.ActionContext;

import com.pojo.Ad;
import com.pojo.Admin;
import com.pojo.Edition;
import com.pojo.Kind;
import com.pojo.Language;
import com.pojo.Member;
import com.pojo.Movie;
import com.service.AdService;
import com.service.EditionService;
import com.service.KindService;
import com.service.LanguageService;
import com.service.MovieService;
import com.util.PageBean;

public class Init implements ServletContextListener {
	
	static private LanguageService languageService;

	public void setLanguageService(LanguageService languageService) {		
		this.languageService = languageService;
		System.out.println("Init中的languageService注入成功");
	}

	static private EditionService editionService;

	public void setEditionService(EditionService editionService) {	
		this.editionService = editionService;
		System.out.println("Init中的editionService注入成功");
	}
	
	static private KindService kindService;

	public void setKindService(KindService kindService) {		
		this.kindService = kindService;
		System.out.println("Init中的kindService注入成功");
	}
	
	static private MovieService movieService;

	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
		System.out.println("Init中的movieService注入成功");
	}

	static private AdService adService;

	public void setAdService(AdService adService) {
		this.adService = adService;
		System.out.println("Init中的adService注入成功");
	}
	
	public void contextDestroyed(ServletContextEvent sce) {

	}

	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("监听器开始工作了！");

		List<Language> lstLanguage = languageService.findAll();
		sce.getServletContext().setAttribute("lstLanguage", lstLanguage);
		System.out.println("Language初始化完成！");

		List<Edition> lstEdition = editionService.findAll();
		sce.getServletContext().setAttribute("lstEdition", lstEdition);
		System.out.println("Edition初始化完成！");

		List<Kind> lstKind=kindService.findAll();
		sce.getServletContext().setAttribute("lstKind", lstKind);
		System.out.println("Kind初始化完成！");
		
		List<Movie> lstMovie=movieService.findAll();
		sce.getServletContext().setAttribute("lstMovie", lstMovie);
		System.out.println("Movie初始化完成！");
		
		List<Ad> lstAd=adService.findAll();
		sce.getServletContext().setAttribute("lstAd", lstAd);
		System.out.println("Ad初始化完成！");
		
		List<Member> onlineMemberList=new ArrayList<Member>();
		sce.getServletContext().setAttribute("onlineMemberList", onlineMemberList);
		System.out.println("用户在线列表初始化完成！");
		
		List<Admin> onlineAdminList=new ArrayList<Admin>();
		sce.getServletContext().setAttribute("onlineAdminList", onlineAdminList);
		System.out.println("管理员在线列表初始化完成！");
	}

}
