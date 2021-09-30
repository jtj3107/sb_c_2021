package com.jtj.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtj.exam.demo.service.MemberService;
import com.jtj.exam.demo.util.Ut;
import com.jtj.exam.demo.vo.Member;
import com.jtj.exam.demo.vo.ResultData;
import com.jtj.exam.demo.vo.Rq;

@Controller
public class UsrMemberController {
	private MemberService memberService;
	private Rq rq;

	public UsrMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPwReal, String name, String nickname, String cellphoneNo,
			String email) {
		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("loginId(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPwReal)) {
			return rq.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		if (Ut.empty(name)) {
			return rq.jsHistoryBack("name(을)를 입력해주세요.");
		}

		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("nickname(을)를 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("cellphoneNo(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}

		ResultData joinRd = memberService.join(loginId, loginPwReal, name, nickname, cellphoneNo, email);

		if (joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getMsg());
		}

		return rq.jsReplace(joinRd.getMsg(), "/");
	}

	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		if (!rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그아웃 상태입니다.");
		}

		rq.logout();

		return rq.jsReplace("로그아웃 되었습니다.", "/");
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPwReal) {
		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("loginId(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPwReal)) {
			return rq.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return rq.jsHistoryBack("존재하지 않는 로그인 아이디 입니다.");
		}

		if (member.getLoginPw().equals(loginPwReal) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		rq.login(member);

		return rq.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), "/");
	}

	@RequestMapping("/usr/member/myPage")
	public String showMyPage() {
		return "usr/member/myPage";
	}

	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {
		return "usr/member/checkPassword";
	}

	@RequestMapping("/usr/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPwReal, String replaceUri) {
		if (Ut.empty(loginPwReal)) {
			return rq.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPwReal) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		if (replaceUri.equals("../member/modify")) {
			String memberModifyAuthKey = memberService.getMemberModifyAuthKey(rq.getLoginedMemberId());

			replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
		}

		return rq.jsReplace("", replaceUri);
	}

	@RequestMapping("/usr/member/modify")
	public String showModify(String memberModifyAuthKey) {
		if (Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("memberModifyAuthKey(이)가 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String memberModifyAuthKey, String loginPwReal, String name, String nickname, String email, String cellphoneNo) {
		if (Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("memberModifyAuthKey(이)가 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		if (Ut.empty(loginPwReal)) {
			loginPwReal = null;
		}

		if (Ut.empty(name)) {
			return rq.jsHistoryBack("name(을)를 입력해주세요.");
		}

		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("nickname(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("cellphoneNo(을)를 입력해주세요.");
		}

		ResultData modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPwReal, name, nickname, email,
				cellphoneNo);

		return rq.jsReplace(modifyRd.getMsg(), "/");
	}
	
	@RequestMapping("/usr/member/findLoginId")
	public String findLoginId() {
		return "usr/member/findLoginId";
	}
	
	@RequestMapping("/usr/member/findLoginPw")
	public String findLoginPw() {
		return "usr/member/findLoginPw";
	}
	
	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String name, String email) {
		if (Ut.empty(name)) {
			return rq.jsHistoryBack("name(을)를 입력해주세요.");
		}
		
		if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}
		
		Member oldMember = memberService.getMemberByNameAndEmail(name, email);
		
		if(oldMember == null) {
			return rq.jsHistoryBack("존재하지 않는 회원입니다.");
		}
		
		String redirectUri = "../member/login?loginId=" + oldMember.getLoginId();
		
		return rq.jsReplace(Ut.f("회원님의 아이디는 `%s`입니다.", oldMember.getLoginId()), redirectUri);
	}
	
	@RequestMapping("/usr/member/doFindLoginPw")
	@ResponseBody
	public String doFindLoginPw(String loginId, String email) {
		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("loginId(을)를 입력해주세요.");
		}
		
		if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}
		
		Member oldMember = memberService.getMemberByLoginId(loginId);
		
		if(oldMember == null) {
			return rq.jsHistoryBack("존재하지 않는 회원입니다.");
		}
		
		if(oldMember.getEmail().equals(email) == false) {
			return rq.jsHistoryBack("회원님의 이메일과 입력하신 이메일이 다릅니다.");
		}
		
		ResultData sendTempLoginPwToEmailRd = memberService.sendTempLoginPwToEmail(oldMember);
		
		if(sendTempLoginPwToEmailRd.isFail()) {
			return rq.jsHistoryBack(sendTempLoginPwToEmailRd.getMsg());
		}
		
		return rq.jsReplace(sendTempLoginPwToEmailRd.getMsg(), "../member/login");
	}
}