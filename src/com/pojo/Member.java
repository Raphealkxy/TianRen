package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Member entity. @author MyEclipse Persistence Tools
 */

public class Member implements java.io.Serializable {

	// Fields

	private Integer memberId;
	private String memberEmail;
	private String memberPwd;
	private String memberName;
	private String memberPhone;
	private Double memberMoney;
	private Boolean memberGender;
	private String memberPhoto;
	private Set tickets = new HashSet(0);

	// Constructors

	/** default constructor */
	public Member() {
	}

	/** minimal constructor */
	public Member(String memberEmail, String memberPwd) {
		this.memberEmail = memberEmail;
		this.memberPwd = memberPwd;
	}

	/** full constructor */
	public Member(String memberEmail, String memberPwd, String memberName,
			String memberPhone, Double memberMoney, Boolean memberGender,
			String memberPhoto, Set tickets) {
		this.memberEmail = memberEmail;
		this.memberPwd = memberPwd;
		this.memberName = memberName;
		this.memberPhone = memberPhone;
		this.memberMoney = memberMoney;
		this.memberGender = memberGender;
		this.memberPhoto = memberPhoto;
		this.tickets = tickets;
	}

	// Property accessors

	public Integer getMemberId() {
		return this.memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getMemberEmail() {
		return this.memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberPwd() {
		return this.memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getMemberName() {
		return this.memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPhone() {
		return this.memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public Double getMemberMoney() {
		return this.memberMoney;
	}

	public void setMemberMoney(Double memberMoney) {
		this.memberMoney = memberMoney;
	}

	public Boolean getMemberGender() {
		return this.memberGender;
	}

	public void setMemberGender(Boolean memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberPhoto() {
		return this.memberPhoto;
	}

	public void setMemberPhoto(String memberPhoto) {
		this.memberPhoto = memberPhoto;
	}

	public Set getTickets() {
		return this.tickets;
	}

	public void setTickets(Set tickets) {
		this.tickets = tickets;
	}

}