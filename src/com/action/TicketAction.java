package com.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Member;
import com.pojo.Play;
import com.pojo.Ticket;
import com.service.MovieService;
import com.service.TicketService;
import com.util.PageBean;

public class TicketAction extends ActionSupport implements ModelDriven<Ticket>{
	private Ticket ticket=new Ticket();
	
	public Ticket getModel() {
		// TODO Auto-generated method stub
		return ticket;
	}
	
	private TicketService ticketService=new TicketService();
	
	public void setTicketService(TicketService ticketService) {
		this.ticketService = ticketService;
	}
	private MovieService movieService=new MovieService();
	
	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}

	/**
	 * 订票
	 * @return
	 * @throws Exception
	 */
	public String addTickets() throws Exception {
		HttpServletRequest request=ServletActionContext.getRequest();
		int playId=Integer.valueOf(request.getParameter("playId"));
		Double ticketPrice=Double.valueOf(request.getParameter("ticketPrice"));
		
		int[] chooseSeatsNum=new int[request.getParameterValues("chooseSeatsNum").length];
		for (int i = 0; i < request.getParameterValues("chooseSeatsNum").length; i++) {
			chooseSeatsNum[i] = Integer.valueOf(request.getParameterValues("chooseSeatsNum")[i]);
		}		
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member member=(Member) session.get("curMember");		
		ticketService.createTicket(member, playId, ticketPrice, chooseSeatsNum);		
		return showOrder();
	}
	
	/**
	 * 显示个人订单
	 * @return
	 * @throws Exception
	 */
	public String showOrder() throws Exception{
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member member=(Member) session.get("curMember");
		
		HttpServletRequest request = ServletActionContext.getRequest();
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter(
					"currentPage").toString());
		}

		int pageSize = 4;
		PageBean ticketsByMemberByPage= ticketService.findByMemberByPage(member, currentPage, pageSize);
		request.setAttribute("ticketsByMemberByPage", ticketsByMemberByPage);
		
		return "myOrder";		
	}
	
	/**
	 * 个人中心显示订单
	 * @return
	 * @throws Exception
	 */
	public String showTodayOrder() throws Exception{
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member member=(Member) session.get("curMember");
		HttpServletRequest request = ServletActionContext.getRequest();
		
		List<Ticket> lstTickets=ticketService.findTodayTicket(member);
		request.setAttribute("lstTickets", lstTickets);
		
		/*
		 * 显示近期影片推荐
		 */
		int afterCurrentPage = 1;
		int afterPageSize = 2;
		PageBean afterMovieByPage = movieService.findAfterByPage(
				afterCurrentPage, afterPageSize);
		request.setAttribute("afterMovieByPage", afterMovieByPage);
		
		return "memberCenter";
	}
	
	/**
	 * 退票
	 * @return
	 * @throws Exception
	 */
	public String returnTicket() throws Exception{
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member member=(Member) session.get("curMember");
		
		HttpServletRequest request = ServletActionContext.getRequest();
		int ticketId=Integer.parseInt(request.getParameter("ticketId"));
		ticket.setTicketId(ticketId);

		ticketService.modifyReturn(ticket,member);
		
		return showOrder();
	}
	
	/**
	 * 后台查询
	 * @return
	 * @throws Exception
	 */
	public String searchTickets() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List<Ticket> lstTickets=ticketService.findTickets(ticket);
		List<Ticket> lstReturnTickets=ticketService.findReturnTickets(ticket);
		
		if(lstTickets.size()!=0){
			Ticket ticket=lstTickets.get(0);
			request.setAttribute("baseInfo", ticket);
			request.setAttribute("lstTickets", lstTickets);
		}
		if(lstReturnTickets.size()!=0){
			Ticket ticket=lstReturnTickets.get(0);
			request.setAttribute("baseInfo", ticket);
			request.setAttribute("lstReturnTickets", lstReturnTickets);
		}

		return "showTickets";
	}
}
