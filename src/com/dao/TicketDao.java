package com.dao;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.dao.base.GenericDaoImpl;
import com.pojo.Ticket;
import com.util.PageBean;

public class TicketDao extends GenericDaoImpl<Ticket, Integer>{
	
	public Ticket selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Ticket> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Ticket ticket){
		super.insert(ticket);
		getHibernateTemplate().clear();
	}
	
	public void delete(Ticket ticket){
		super.delete(ticket);
	}
	
	public void update(Ticket ticket){
		super.update(ticket);
	}
	
	/**
	 * 分页显示个人订单
	 * @param memberId
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean selectByMemberIdByPage(Integer memberId,int currentPage, int pageSize){
		Criteria criteria_data = createCriteria();
		Criteria criteria_data_member = criteria_data.createAlias("member", "member");
		criteria_data_member.add(Restrictions.eq("member.memberId", memberId));
		criteria_data.addOrder(Order.desc("ticketDate"));
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);
		
		List<Ticket> lstTickets=criteria_data.list();
		
		Criteria criteria_totalRows = createCriteria();		
		Criteria criteria_totalRows_member = criteria_totalRows.createAlias("member", "member");
		criteria_totalRows_member.add(Restrictions.eq("member.memberId", memberId));	
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());
		
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstTickets);
		
		return pageBean;		
	}
	
	/**
	 * 查询今天场次订单
	 * @return
	 */
	public List<Ticket> selectTodayOrderByMemberId(Integer memberId){		
		Criteria criteria = createCriteria();
		criteria.add(Restrictions.eq("ticketFlag", true));
		Criteria criteria_member = criteria.createAlias("member", "member");
		criteria_member.add(Restrictions.eq("member.memberId", memberId));
		Criteria criteria_play = criteria.createAlias("play", "play");		
		criteria_play.add(Restrictions.ge("play.playTime", new Timestamp(new Date().getTime())));		
		criteria.addOrder(Order.desc("ticketDate"));
		
		List<Ticket> lstTickets=criteria.list();
		return lstTickets;		
	}
	
	/**
	 * 根据订单号查未退票
	 * @param ticketCode
	 * @return
	 */
	public List<Ticket> selectByCode(String ticketCode){
		Criteria criteria = createCriteria();
		criteria.add(Restrictions.eq("ticketCode", ticketCode));
		criteria.add(Restrictions.eq("ticketFlag", true));
		List<Ticket> lstTickets=criteria.list();
		return lstTickets;
	}
	
	/**
	 * 根据订单号查退票
	 * @param ticketCode
	 * @return
	 */
	public List<Ticket> selectReturnByCode(String ticketCode){
		Criteria criteria = createCriteria();
		criteria.add(Restrictions.eq("ticketCode", ticketCode));
		criteria.add(Restrictions.eq("ticketFlag", false));
		List<Ticket> lstTickets=criteria.list();
		return lstTickets;
	}
}
