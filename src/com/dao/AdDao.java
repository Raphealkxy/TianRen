package com.dao;

import java.util.HashSet;
import java.util.List;

import com.dao.base.GenericDaoImpl;
import com.pojo.Ad;

public class AdDao extends GenericDaoImpl<Ad, Integer>{
	
	public Ad selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Ad> selectAll(){
		return super.selectAll();
	}
	
	public void update(Ad ad){
		super.update(ad);		
		getHibernateTemplate().flush();
	}
	
}
