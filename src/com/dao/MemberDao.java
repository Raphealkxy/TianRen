package com.dao;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

import com.dao.base.GenericDaoImpl;
import com.pojo.Member;
import com.util.PageBean;

public class MemberDao extends GenericDaoImpl<Member, Integer>{
	
	public Member selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Member> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Member member){
		super.insert(member);
	}
	
	public void delete(Member member){
		super.delete(member);
	}
	
	public void update(Member member){
		super.update(member);
		getHibernateTemplate().flush();
	}
	
	public List<Member> selectByExample(Member member){
		return super.selectByExample(member);
	}
	
	public PageBean selectLikeByEntityByPage(Member member,String[] propertyNames, int currentPage,int pageSize){
		return super.selectLikeByEntityByPage(member, propertyNames, currentPage, pageSize);
	}
}
