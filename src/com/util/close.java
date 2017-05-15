package com.util;

import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.Admin;
import com.pojo.Member;

public class close extends ActionSupport {
	public void closeClient() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Map<String, Object> application = ActionContext.getContext()
				.getApplication();
		if (session.get("curMember") != null) {
			List<Member> onlineMemberList = (List<Member>) application.get("onlineMemberList");
			// 在线列表移除
			onlineMemberList.remove(session.get("curMember"));			
		}
		if (session.get("curAdmin") != null) {
			List<Admin> onlineAdminList = (List<Admin>) application.get("onlineAdminList");
			// 在线列表移除
			onlineAdminList.remove(session.get("curAdmin"));
		}
		session.clear();
	}
}
