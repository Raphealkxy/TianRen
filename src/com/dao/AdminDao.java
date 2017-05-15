package com.dao;

import java.util.List;

import com.dao.base.GenericDaoImpl;
import com.pojo.Admin;

public class AdminDao extends GenericDaoImpl<Admin, Integer>{
	
	public Admin selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Admin> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Admin admin){
		super.insert(admin);
	}
	
	public void delete(Admin admin){
		super.delete(admin);
	}
	
	public void update(Admin admin){
		super.update(admin);
		getHibernateTemplate().flush();
	}
	
	public List<Admin> selectEqualByEntity(Admin admin){
		//return super.selectEqualByEntity(admin, propertyNames);
		return super.selectByExample(admin);
	}
	
}
