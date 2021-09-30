package com.jtj.exam.demo.service;

import org.springframework.stereotype.Service;

import com.jtj.exam.demo.app.App;
import com.jtj.exam.demo.util.Ut;

@Service
public class EmailService {

	public int notify(String to, String title, String body) {
		App app = new App();
		String smtpGmailId = app.getSmtpGmailId();
		String smtpGmailPw = app.getSmtpGmailPw();
		String from = "no-reply@lemon-cm.com";
		String fromName = app.getNotifyEmailFromName();

		return Ut.sendMail(smtpGmailId, smtpGmailPw, from, fromName, to, title, body);
	}
}
