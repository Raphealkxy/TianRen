package com.pojo;

/**
 * Ad entity. @author MyEclipse Persistence Tools
 */

public class Ad implements java.io.Serializable {

	// Fields

	private Integer adId;
	private String adImg;
	private String adHref;

	// Constructors

	/** default constructor */
	public Ad() {
	}

	/** full constructor */
	public Ad(String adImg, String adHref) {
		this.adImg = adImg;
		this.adHref = adHref;
	}

	// Property accessors

	public Integer getAdId() {
		return this.adId;
	}

	public void setAdId(Integer adId) {
		this.adId = adId;
	}

	public String getAdImg() {
		return this.adImg;
	}

	public void setAdImg(String adImg) {
		this.adImg = adImg;
	}

	public String getAdHref() {
		return this.adHref;
	}

	public void setAdHref(String adHref) {
		this.adHref = adHref;
	}

}