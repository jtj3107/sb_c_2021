<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../common/head.jspf"%>

<script>
	let CheckLoginPw__submitDone = false;
	function CheckLoginPw__submit(form) {
		if (CheckLoginPw__submitDone) {
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = "";
		
		form.submit();
		CheckLoginPw__submitDone = true;
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <form class="table-box-type-1" method="POST" action="../member/doCheckPassword" onsubmit="CheckLoginPw__submit(this); return false;">
      <input type="hidden" name="replaceUri" value="${param.replaceUri}" />
      <input type="hidden" name="loginPwReal" />
      <table>
        <colgroup>
          <col width="200" />
        </colgroup>
        <tbody>
          <tr>
            <th>로그인아이디</th>
            <td>${rq.loginedMember.loginId}</td>
          </tr>
          <tr>
            <th>로그인비밀번호</th>
            <td>
              <input name="loginPw" class="w-96 input input-bordered" type="password" placeholder="로그인비밀번호" required="required" />
            </td>
          </tr>
          <tr>
            <th>비밀번호 확인</th>
            <td>
              <button type="submit" class="btn btn-primary">비밀번호 확인</button>
              <button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>