package com.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Play entity. @author MyEclipse Persistence Tools
 */

public class Play implements java.io.Serializable {

	// Fields

	private Integer playId;
	private Movie movie;
	private Timestamp playTime;
	private Double playPrice;
	private Set tickets = new HashSet(0);

	// Constructors

	/** default constructor */
	public Play() {
	}

	/** minimal constructor */
	public Play(Movie movie, Double playPrice) {
		this.movie = movie;
		this.playPrice = playPrice;
	}

	/** full constructor */
	public Play(Movie movie, Timestamp playTime, Double playPrice, Set tickets) {
		this.movie = movie;
		this.playTime = playTime;
		this.playPrice = playPrice;
		this.tickets = tickets;
	}

	// Property accessors

	public Integer getPlayId() {
		return this.playId;
	}

	public void setPlayId(Integer playId) {
		this.playId = playId;
	}

	public Movie getMovie() {
		return this.movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public Timestamp getPlayTime() {
		return this.playTime;
	}

	public void setPlayTime(Timestamp playTime) {
		this.playTime = playTime;
	}

	public Double getPlayPrice() {
		return this.playPrice;
	}

	public void setPlayPrice(Double playPrice) {
		this.playPrice = playPrice;
	}

	public Set getTickets() {
		return this.tickets;
	}

	public void setTickets(Set tickets) {
		this.tickets = tickets;
	}

}