package com.jtj.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtj.exam.demo.service.MemberService;
import com.jtj.exam.demo.util.Ut;
import com.jtj.exam.demo.vo.Member;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public Object doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		if (Ut.empty(loginId)) {
			return "loginId(을)를 입력해주세요";
		}

		if (Ut.empty(loginPw)) {
			return "loginPw(을)를 입력해주세요";
		}

		if (Ut.empty(name)) {
			return "name(을)를 입력해주세요";
		}

		if (Ut.empty(nickname)) {
			return "nickname(을)를 입력해주세요";
		}

		if (Ut.empty(cellphoneNo)) {
			return "cellphoneNo(을)를 입력해주세요";
		}

		if (Ut.empty(email)) {
			return "email(을)를 입력해주세요";
		}

		int id = memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);

		if (id == -1) {
			return "해당 `" + loginId + "`는 이미 사용중인 아이디 입니다.";
		}
		
		if(id == -2) {
			return "해당 `" + name + "`과 `" + email + "`은 이미 사용중 입니다.";
		}

		Member member = memberService.getMemberById(id);

		return member;
	}
}
