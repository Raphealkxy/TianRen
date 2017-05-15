package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pojo.Admin;

public class SecurityFilter implements Filter {

	public void destroy() {
		System.out.println("安全过滤器销毁了！");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("安全过滤器工作了！");
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		String uri = httpRequest.getRequestURI();
		if (!uri.contains("/admin/")) {
			if (uri.contains("/memberCenter.jsp")
					|| uri.contains("/myOrder.jsp") || uri.contains("/pay.jsp")
					|| uri.contains("/seat.jsp")
					|| uri.contains("/updateInfo.jsp")
					|| uri.contains("/updatePwd.jsp")) {
				if (session.getAttribute("curMember") == null) {
					httpResponse.sendRedirect(httpRequest.getContextPath()
							+ "/login.jsp");
				}
			}
		} else {
			if (!uri.contains("/adminLogin.jsp")) {
				if (session.getAttribute("curAdmin") == null) {
					httpResponse.sendRedirect(httpRequest.getContextPath()
							+ "/admin/adminLogin.jsp");
				} else {
					String privilege = ((Admin) session
							.getAttribute("curAdmin")).getAdminPrivilege();
					if (uri.contains("Movie")) {
						if (!privilege.contains("1")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
					if (uri.contains("Play")) {
						if (!privilege.contains("2")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
					if (uri.contains("Member")) {
						if (!privilege.contains("3")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
					if(uri.contains("Ticket")){
						if (!privilege.contains("4")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
					if (uri.contains("Ad")) {
						if (!privilege.contains("5")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
					if (uri.contains("Admin")) {
						if (!privilege.contains("6")) {
							httpResponse
									.sendRedirect(httpRequest.getContextPath()
											+ "/admin/adminIndex.jsp");
						}
					}
				}
			}
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("安全过滤器初始化了！");
	}

}
