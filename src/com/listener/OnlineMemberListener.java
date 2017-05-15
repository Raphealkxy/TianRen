package com.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.pojo.Admin;
import com.pojo.Member;

public class OnlineMemberListener implements HttpSessionListener{

	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();   
		ServletContext application = session.getServletContext();   
		
		// 取得登录的用户
		if(session.getAttribute("curMember")!=null){
			List<Member> onlineMemberList = (List<Member>) application.getAttribute("onlineMemberList");
			Member curMember = (Member) session.getAttribute("curMember");   
			// 从在线列表中删除用户		   
			onlineMemberList.remove(curMember);   
			System.out.println("用户："+curMember.getMemberEmail() + "超时退出。");   
		}
		if(session.getAttribute("curAdmin")!=null){
			List<Admin> onlineAdminList = (List<Admin>) application.getAttribute("onlineAdminList");
			Admin curAdmin = (Admin) session.getAttribute("curAdmin");   
			// 从在线列表中删除管理员		   
			onlineAdminList.remove(curAdmin);   
			System.out.println("管理员："+curAdmin.getAdminName() + "超时退出。");   
		}
	}

}
