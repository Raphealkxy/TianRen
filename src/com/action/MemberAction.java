package com.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import com.pojo.Member;
import com.service.MemberService;
import com.util.FileProcessUitl;
import com.util.PageBean;

public class MemberAction extends ActionSupport implements ModelDriven<Member> {

	private Member member = new Member();

	public Member getModel() {
		// TODO Auto-generated method stub
		return member;
	}

	private String checkCode;

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	private MemberService memberService;

	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
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
	 * 检查新注册邮箱是否存在
	 * 
	 * @throws Exception
	 */
	public void IsExistMemberEmail() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(memberService.isExistEmail(member));
		out.flush();
		out.close();
	}

	/**
	 * 注册
	 * 
	 * @return
	 * @throws Exception
	 */
	public String register() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();

		String checkCode = request.getParameter("checkCode").toString().trim();
		String rand = (String) ActionContext.getContext().getSession()
				.get("rand");
		if (checkCode.equals(rand)) {
			memberService.create(member);

			Map<String, Object> session = ActionContext.getContext()
					.getSession();
			session.put("curMember", memberService.login(member));

			return "index";
		} else {
			return null;
		}
	}

	/**
	 * 检查验证码
	 * 
	 * @throws Exception
	 */
	public void checkCode() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		String checkCode = request.getParameter("checkCode").toString().trim();
		String rand = (String) ActionContext.getContext().getSession()
				.get("rand");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		if (checkCode.equals(rand)) {
			out.print(true);
		} else {
			out.print(false);
		}
		out.flush();
		out.close();
	}

	/**
	 * 登录与Cookie
	 * 
	 * @throws Exception
	 */
	public void login() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		HttpServletRequest request=ServletActionContext.getRequest();
		
		Map<String, Object> session = ActionContext.getContext()
				.getSession();
		
		Boolean auto=Boolean.parseBoolean(request.getParameter("auto"));
		
		Member curMember = memberService.login(member);
		boolean flagOnline=false;
		if (curMember != null) {
			Map<String,Object> application=ActionContext.getContext().getApplication();
			//在线列表
			List<Member> onlineMemberList=(List<Member>) application.get("onlineMemberList");
			for (Member member : onlineMemberList) {
				if(member.getMemberId().intValue()==curMember.getMemberId().intValue()){
					flagOnline=true;
				}
			}
			if(session.get("curMember") != null){
				if(curMember.getMemberId().intValue()==((Member)session.get("curMember")).getMemberId().intValue()){
					flagOnline = false;
				}
			}
			if(!flagOnline){
				//在线列表添加
				if(session.get("curMember") != null){
					if(curMember.getMemberId().intValue()!=((Member)session.get("curMember")).getMemberId().intValue()){
						onlineMemberList.add(curMember);
					}
				}
				
				session.put("curMember", curMember);
				
				if (auto) { // 如果勾选了下次自动登录的复选框，在登录的同时，将用户信息保存在Cookie中，并存储到客户端！
					// 新建的Cookie用户保存客户的登录信息！
					Cookie cookie = new Cookie("TianRenInfo", member.getMemberEmail() + "," + member.getMemberPwd());
					cookie.setMaxAge(60 * 60 * 24 * 30);
					// 将cookie存放到客户端！
					response.addCookie(cookie);
					
				} else { // 如果用户没有勾选，下次自动登录的复选框，在找出曾经保存过的Cookie记录，如果存在将其删除！
					
					Cookie[] cookies = request.getCookies();
					for (Cookie cookie : cookies) {
						if ("TianRenInfo".equals(cookie.getName())) {
							// Cookie的删除，就是将它的过期时间调整成 0 即可！
							cookie.setMaxAge(0);
							// 将这个Cookie重新，抛向客户端，使其过期失效！
							response.addCookie(cookie);
							break;
						}
					}
				}
				
				out.print(true);
			}else{
				out.print("online");
			}
		} else {
			out.print(false);
		}
		out.flush();
		out.close();
	}

	/**
	 * 注销
	 * 
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Map<String,Object> application=ActionContext.getContext().getApplication();
		//在线列表移除
		List<Member> onlineMemberList=(List<Member>) application.get("onlineMemberList");
		onlineMemberList.remove(session.get("curMember"));
		
		session.clear();
		
		return "index";
	}

	/**
	 * 分页模糊查询用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String searchMembersByPage() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getParameter("searchWord") != null) {
			member.setMemberName(new String(request.getParameter("searchWord")
					.toString().trim().getBytes("ISO8859-1"), "UTF-8"));
		}

		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")
					.toString());
		}

		int pageSize = 8;
		if (request.getParameter("pageSize") != null) {
			pageSize = Integer.parseInt(request.getParameter("pageSize")
					.toString());
		}

		PageBean searchMembersByPage = memberService.findLikeByEntityByPage(
				member, new String[] { "memberName" }, currentPage, pageSize);

		request.setAttribute("searchMembersByPage", searchMembersByPage);
		request.setAttribute("searchWord", member.getMemberName());
		return "showMembers";
	}

	/**
	 * 修改用户信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberInfo() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		session.put("curMember", memberService.modifyInfo(curMember, member));
		return "updateInfo";
	}

	/**
	 * 修改上传用户头像
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberPhoto() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadMember", upload,
				uploadFileName);
		member.setMemberPhoto(path);
		session.put("curMember", memberService.modifyPhoto(curMember, member));
		return "updateInfo";
	}

	/**
	 * 修改用户密码
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberPwd() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		session.put("curMember", memberService.modifyPwd(curMember, member));
		return "updatePwd";
	}

	/**
	 * 检查旧密码是否一致
	 * 
	 * @throws Exception
	 */
	public void checkOldMemberPwd() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(memberService.checkOldPwd((Member) session.get("curMember"),
				member));
		out.flush();
		out.close();
	}

	/**
	 * 添加用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveMember() throws Exception {
		memberService.create(member);
		return searchMembersByPage();
	}

	/**
	 * 删除用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String removeMember() throws Exception {
		memberService.remove(member);
		return searchMembersByPage();
	}

	/**
	 * 根据ID查用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findMemberById() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("member", memberService.findById(member));
		return "updateMember";
	}

	/**
	 * 修改用户
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMember() throws Exception {
		memberService.modify(member);
		return searchMembersByPage();
	}
	
	/**
	 * 在登录的时候直接校验客户端的登录信息，如果存在就直接登录，而不需要跳转到登陆界面去输入信息！
	 * @return
	 * @throws Exception
	 */
	public String prepareLogin() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		//从客户端获取Cookie
		Cookie[] cookies = request.getCookies();
		
		Map<String, Object> session = ActionContext.getContext()
				.getSession();
		
		String memberEmail = null;
		String memberPwd = null;
		//如果找到曾经保存过的登录信息，就将记录提取出来！
		for (Cookie cookie : cookies) {
			if("TianRenInfo".equals(cookie.getName())) {
				String[] studentInfo = cookie.getValue().split(",");
				memberEmail = studentInfo[0];
				memberPwd = studentInfo[1];	
				break;
			}
		}
		//如果提取出来的用户信息不为空，就执行登录操作！否则证明Cookie已经不存在了！
		if(memberEmail!=null && memberPwd !=null) {
			member.setMemberEmail(memberEmail);
			member.setMemberPwd(memberPwd);
			Member curMember = memberService.login(member);			
			session.put("curMember", curMember);
		}
		session.put("cookieFlag", true);
		return "index";		
	}
}
