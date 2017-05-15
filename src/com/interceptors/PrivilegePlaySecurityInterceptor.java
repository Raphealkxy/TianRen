package com.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.pojo.Admin;

public class PrivilegePlaySecurityInterceptor extends MethodFilterInterceptor{
	private String name;
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public void init() {
		super.init();
		System.out.println("场次管理权限安全拦截器"+name+"初始化了！");
	}

	@Override
	public void destroy() {
		super.destroy();
		System.out.println("场次管理权限安全拦截器"+name+"销毁了！");
	}

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("场次管理权限安全拦截器"+name+"工作了！");
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		if (session.get("curAdmin") != null) {
			if(((Admin)session.get("curAdmin")).getAdminPrivilege().indexOf("2")!=-1){
				return invocation.invoke();
			}else{
				return "adminLogin";
			}
		} else {
			return "adminLogin";
		}
	}

}
