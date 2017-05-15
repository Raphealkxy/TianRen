package com.pojo;

/**
 * Admin entity. @author MyEclipse Persistence Tools
 */

public class Admin implements java.io.Serializable {

	// Fields

	private Integer adminId;
	private String adminName;
	private String adminPwd;
	private String adminPrivilege;

	// Constructors

	/** default constructor */
	public Admin() {
	}

	/** full constructor */
	public Admin(String adminName, String adminPwd, String adminPrivilege) {
		this.adminName = adminName;
		this.adminPwd = adminPwd;
		this.adminPrivilege = adminPrivilege;
	}

	// Property accessors

	public Integer getAdminId() {
		return this.adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public String getAdminName() {
		return this.adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminPwd() {
		return this.adminPwd;
	}

	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}

	public String getAdminPrivilege() {
		return this.adminPrivilege;
	}

	public void setAdminPrivilege(String adminPrivilege) {
		this.adminPrivilege = adminPrivilege;
	}

}