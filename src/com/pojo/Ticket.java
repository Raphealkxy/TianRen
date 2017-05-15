package com.pojo;

import java.sql.Timestamp;

/**
 * Ticket entity. @author MyEclipse Persistence Tools
 */

public class Ticket implements java.io.Serializable {

	// Fields

	private Integer ticketId;
	private Play play;
	private Member member;
	private String ticketCode;
	private Integer ticketSeat;
	private Double ticketPrice;
	private Timestamp ticketDate;
	private Boolean ticketFlag;

	// Constructors

	/** default constructor */
	public Ticket() {
	}

	/** minimal constructor */
	public Ticket(Play play, Member member, String ticketCode,
			Integer ticketSeat, Double ticketPrice, Boolean ticketFlag) {
		this.play = play;
		this.member = member;
		this.ticketCode = ticketCode;
		this.ticketSeat = ticketSeat;
		this.ticketPrice = ticketPrice;
		this.ticketFlag = ticketFlag;
	}

	/** full constructor */
	public Ticket(Play play, Member member, String ticketCode,
			Integer ticketSeat, Double ticketPrice, Timestamp ticketDate,
			Boolean ticketFlag) {
		this.play = play;
		this.member = member;
		this.ticketCode = ticketCode;
		this.ticketSeat = ticketSeat;
		this.ticketPrice = ticketPrice;
		this.ticketDate = ticketDate;
		this.ticketFlag = ticketFlag;
	}

	// Property accessors

	public Integer getTicketId() {
		return this.ticketId;
	}

	public void setTicketId(Integer ticketId) {
		this.ticketId = ticketId;
	}

	public Play getPlay() {
		return this.play;
	}

	public void setPlay(Play play) {
		this.play = play;
	}

	public Member getMember() {
		return this.member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getTicketCode() {
		return this.ticketCode;
	}

	public void setTicketCode(String ticketCode) {
		this.ticketCode = ticketCode;
	}

	public Integer getTicketSeat() {
		return this.ticketSeat;
	}

	public void setTicketSeat(Integer ticketSeat) {
		this.ticketSeat = ticketSeat;
	}

	public Double getTicketPrice() {
		return this.ticketPrice;
	}

	public void setTicketPrice(Double ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public Timestamp getTicketDate() {
		return this.ticketDate;
	}

	public void setTicketDate(Timestamp ticketDate) {
		this.ticketDate = ticketDate;
	}

	public Boolean getTicketFlag() {
		return this.ticketFlag;
	}

	public void setTicketFlag(Boolean ticketFlag) {
		this.ticketFlag = ticketFlag;
	}

}