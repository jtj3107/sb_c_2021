<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<c:set var="pageTitle" value="회원정보수정" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberModify__submitDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitDone) {
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();

			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호확인을 입력해주세요.');
				form.loginPwConfirm.focus();

				return;
			}

			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호확인이 일치하지 않습니다.');
				form.loginPwConfirm.focus();

				return;
			}
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.')
			form.name.focus();

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			alert('별명을 입력해주세요.')
			form.nickname.focus();

			return;
		}
		
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.')
			form.email.focus();

			return;
		}
		
		form.cellphoneNo.value = form.cellphoneNo.value.trim();

		if (form.cellphoneNo.value.length == 0) {
			alert('휴대전화번호를 입력해주세요.')
			form.cellphoneNo.focus();

			return;
		}
		
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = "";
		form.loginPwConfirm.value = "";

		MemberModify__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <form class="table-box-type-1" method="POST" action="../member/doModify" onsubmit="MemberModify__submit(this); return false;">
      <input type="hidden" name="memberModifyAuthKey" value="${param.memberModifyAuthKey}" />
      <input type="hidden" name="loginPwReal" />
      <table>
        <colgroup>
          <col width="200" />
        </colgroup>
        <tbody>
          <tr>
            <th>로그인 아이디</th>
            <td>${rq.loginedMember.loginId}</td>
          </tr>
          <tr>
            <th>새 로그인비밀번호</th>
            <td>
              <input class="input input-bordered" name="loginPw" type="password" placeholder="새 비밀번호를 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>새 로그인비밀번호 확인</th>
            <td>
              <input class="input input-bordered" name="loginPwConfirm" type="password" placeholder="새 비밀번호를 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>이름</th>
            <td>
              <input class="input input-bordered" name="name" type="text" placeholder="이름을 입력해주세요." value="${rq.loginedMember.name}" />
            </td>
          </tr>
          <tr>
            <th>별명</th>
            <td>
              <input class="input input-bordered" name="nickname" type="text" placeholder="별명을 입력해주세요." value="${rq.loginedMember.nickname}" />
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td>
              <input class="input input-bordered" name="email" type="email" placeholder="이메일을 입력해주세요." value="${rq.loginedMember.email}" />
            </td>
          </tr>
          <tr>
            <th>휴대전화번호</th>
            <td>
              <input class="input input-bordered" name="cellphoneNo" type="tel" placeholder="휴대전화번호를 입력해주세요."
                value="${rq.loginedMember.cellphoneNo}" />
            </td>
          </tr>
          <tr>
            <th>회원정보수정</th>
            <td>
              <button type="submit" class="btn btn-primary">회원정보수정</button>
              <button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>