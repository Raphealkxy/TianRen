package com.service;

import java.util.List;

import com.dao.AdminDao;
import com.pojo.Admin;
import com.util.PageBean;

public class AdminService {
	
	private AdminDao adminDao;

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	/**
	 * 管理员登录
	 * @param admin
	 * @return
	 */
	public Admin login(Admin admin){
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()==0){
			return null;
		}else{
			return lstAdmin.get(0);
		}		
	}	
	
	/**
	 * 查询所有管理员
	 * @return
	 */
	public List<Admin> findAll(){
		return adminDao.selectAll();
	}
	
	/**
	 * 添加管理员
	 * @param admin
	 */
	public void create(Admin admin){
		adminDao.insert(admin);
	}
	
	/**
	 * 根据登录名查询
	 * @param adminName
	 * @return
	 */
	public boolean findByName(String adminName){
		Admin admin=new Admin();
		admin.setAdminName(adminName);
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 根据ID查管理员
	 * @param admin
	 * @return
	 */
	public Admin findById(Admin admin){
		return adminDao.selectById(admin.getAdminId());
	}
	
	/**
	 * 修改管理员
	 * @param admin
	 */
	public void modifyAdmin(Admin admin){
		adminDao.update(admin);
	}
	
	/**
	 * 删除管理员
	 * @param admin
	 */
	public void remove(Admin admin){
		adminDao.delete(adminDao.selectById(admin.getAdminId()));
	}
}
