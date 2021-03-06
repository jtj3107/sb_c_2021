<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberJoin__submitDone = false;
	let MemberJoin__checkedLoginId = "";

	function MemberJoin__checkLoginIdDup(el) {
		const form = $(el).closest('form').get(0);
		form.loginId.value = form.loginId.value.trim();
		$(form).find('.input-loginId-alert').addClass('display-none');
	
		if (form.loginId.value.length == 0) {
			return;
		}
		
		if (form.loginId.value == MemberJoin__checkedLoginId) {
			$(form).find('.input-loginId-alert.alert-success').removeClass(
					'display-none');
			return;
		}
		
		$.get("../member/getLoginIdDup", {
			ajax : "Y",
			loginId : form.loginId.value
		}, function(data) {
			if (data.success) {
				MemberJoin__checkedLoginId = data.data1Name.loginId;
				$(form).find('.input-loginId-alert.alert-success label').text(
						data.msg);
				$(form).find('.input-loginId-alert.alert-success').removeClass(
						'display-none');
			} else {
				$(form).find('.input-loginId-alert.alert-error label').text(
						data.msg);
				$(form).find('.input-loginId-alert.alert-error').removeClass(
						'display-none');
			}
		}, "json");
	}

	function MemberJoin__submit(form) {
		if (MemberJoin__submitDone) {
			return;
		}
		if (form.agreementTermsOfService.checked == false) {
			alert('이용약관에 동의해야 진행할 수 있습니다.');
			form.agreementTermsOfService.focus();
			return;
		}
		if (form.agreementPrivacyPolicy.checked == false) {
			alert('개인정보취급방침에 동의해야 진행할 수 있습니다.');
			form.agreementPrivacyPolicy.focus();
			return;
		}
		// 좌우 공백제거
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('로그인 아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('로그인 비밀번호 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');
			form.loginPwConfirm.focus();
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('전화번호를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = "";
		form.loginPwConfirm.value = "";

		MemberJoin__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <form action="../member/doJoin" method="POST" onsubmit="MemberJoin__submit(this); return false;">
      <input type="hidden" name="loginPwReal" />
      <div class="form-control">
        <label class="label">
          <span class="label-text">
            <span>이용약관</span>
            <a href="#" class="s-link">다시 확인하기</a>
          </span>
        </label>
        <div>
          <label class="flex">
            <input type="checkbox" class="checkbox" name="agreementTermsOfService">
            <span class="ml-2">이용약관에 동의합니다.</span>
          </label>
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">
            <span>개인정보취급방침</span>
            <a href="#" class="s-link">다시 확인하기</a>
          </span>
        </label>
        <div>
          <label class="flex">
            <input type="checkbox" class="checkbox" name="agreementPrivacyPolicy">
            <span class="ml-2">개인정보취급방침에 동의합니다.</span>
          </label>
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">로그인 아이디</span>
        </label>
        <div>
          <input autocomplete="off" class="input input-bordered w-full" maxlength="100" name="loginId" type="text"
            placeholder="사용하실 로그인아이디를 입력해주세요." onchange="MemberJoin__checkLoginIdDup(this);" onkeyup="MemberJoin__checkLoginIdDup(this);" />
          <div class="alert display-none input-loginId-alert alert-success mt-2">
            <div class="flex-1">
              <span>
                <i class="fas fa-check-circle"></i>
              </span>
              <label></label>
            </div>
          </div>
          <div class="alert display-none input-loginId-alert alert-error mt-2">
            <div class="flex-1">
              <span>
                <i class="fas fa-check-circle"></i>
              </span>
              <label></label>
            </div>
          </div>
          <div></div>
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">로그인 비밀번호</span>
        </label>
        <div>
          <input class="input input-bordered w-full" maxlength="100" name="loginPw" type="password" placeholder="사용하실 로그인 비밀번호를 입력해주세요." />
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">로그인 비밀번호 확인</span>
        </label>
        <div>
          <input class="input input-bordered w-full" maxlength="100" name="loginPwConfirm" type="password" placeholder="로그인비밀번호 확인을 입력해주세요." />
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">이름</span>
        </label>
        <div>
          <input class="input input-bordered w-full" maxlength="100" name="name" type="text" placeholder="이름을 입력해주세요." />
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">닉네임</span>
        </label>
        <div>
          <input class="input input-bordered w-full" maxlength="100" name="nickname" type="text" placeholder="닉네임을 입력해주세요." />
        </div>
      </div>

      <div class="form-control">
        <label class="label">
          <span class="label-text">이메일</span>
        </label>
        <div>
          <input class="input input-bordered w-full" id="emailText" maxlength="100" name="email" type="email" placeholder="이메일을 입력해주세요." />
        </div>
      </div>
      <div class="form-control">
        <label class="label">
          <span class="label-text">전화번호</span>
        </label>
        <div>
          <input class="input input-bordered w-full" maxlength="100" name="cellphoneNo" type="tel" placeholder="휴대전화번호를 입력해주세요." />
        </div>
      </div>

      <div class="btns">
        <button type="submit" class="btn btn-link">회원가입</button>
      </div>
    </form>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>