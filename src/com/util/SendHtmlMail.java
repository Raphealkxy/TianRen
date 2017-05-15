package com.util;

import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class SendHtmlMail {
	public void sendHtmlMail(String toEmail, String HtmlMsg) {

		HtmlEmail email = new HtmlEmail();

		email.setCharset("UTF-8");
		email.setHostName("smtp.sina.com");
		email.setSmtpPort(25);
		email.setAuthentication("tianrenemail@sina.com", "tianren");
		email.setTLS(true);

		try {
			email.addTo(toEmail);

			email.setFrom("tianrenemail@sina.com");
			email.setSubject("天仁电影"); // 标题
			email.setMsg("订票信息");

			URL url = new URL(
					"http://localhost:8888/TianRen/uploadAd/31049534581071.gif");
			String cid = email.embed(url, "TianRen Logo");

			email.setHtmlMsg("<html><a href='http://localhost:8888/TianRen/index.jsp'><img src=\"cid:"
					+ cid + "\" height=\"75\"></a><br/>" + HtmlMsg + "</html>");

			email.send();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
