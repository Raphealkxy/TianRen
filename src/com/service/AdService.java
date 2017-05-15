package com.service;

import java.util.HashSet;
import java.util.List;

import com.dao.AdDao;
import com.pojo.Ad;

public class AdService {
	private AdDao adDao;

	public void setAdDao(AdDao adDao) {
		this.adDao = adDao;
	}
	
	public List<Ad> findAll(){
		return adDao.selectAll();
	}
	
	public void modify(Ad ad){
		Ad OldAd=adDao.selectById(ad.getAdId());
		
		OldAd.setAdHref(ad.getAdHref());
		if(ad.getAdImg()!=null){
			OldAd.setAdImg(ad.getAdImg());
		}
			
		adDao.update(OldAd);
	}
}
