<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<c:set var="pageTitle" value="비밀번호 찾기" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberFindLoginPw__submitDone = false;
	function MemberFindLoginPw__submit(form) {
		if (MemberFindLoginPw__submitDone) {
			return;
		}

		// 좌우 공백제거
		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('로그인아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일를 입력해주세요.');
			form.email.focus();
			return;
		}

		MemberFindLoginPw__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <form class="table-box-type-1" method="POST" action="../member/doFindLoginPw" onsubmit="MemberFindLoginPw__submit(this); return false;">
      <table>
        <colgroup>
          <col width="200" />
        </colgroup>
        <tbody>
          <tr>
            <th>로그인아이디</th>
            <td>
              <input name="loginId" class="w-96 input input-bordered" type="text" placeholder="로그인아이디를 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td>
              <input name="email" class="w-96 input input-bordered" type="email" placeholder="이메일를 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>비밀번호 찾기</th>
            <td>
              <button type="submit" class="btn btn-primary">비밀번호 찾기</button>
              <button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
    <a class="btn btn-link" href="../member/join">회원가입</a>
    <a class="btn btn-link" href="../member/findLoginPw">아이디 찾기</a>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>