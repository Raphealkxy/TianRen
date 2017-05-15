package com.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class MemberSecurityInterceptor  extends MethodFilterInterceptor{
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
		System.out.println("前台用户安全拦截器"+name+"初始化了！");
	}
	
	@Override
	public void destroy() {		
		super.destroy();
		System.out.println("前台用户安全拦截器"+name+"销毁了！");
	}

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("前台用户安全拦截器"+name+"工作了！");
		Map<String, Object> session=invocation.getInvocationContext().getSession();
		if(session.get("curMember")!=null){
			return invocation.invoke();
		}else{
			return "login";
		}
	}
}
