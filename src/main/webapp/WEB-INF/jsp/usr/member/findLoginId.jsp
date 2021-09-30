<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberFindLoginId__submitDone = false;
	function MemberFindLoginId__submit(form) {
		if (MemberFindLoginId__submitDone) {
			return;
		}

		// 좌우 공백제거
		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일를 입력해주세요.');
			form.email.focus();
			return;
		}

		MemberFindLoginId__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <form class="table-box-type-1" method="POST" action="../member/doFindLoginId" onsubmit="MemberFindLoginId__submit(this); return false;">
      <table>
        <colgroup>
          <col width="200" />
        </colgroup>
        <tbody>
          <tr>
            <th>이름</th>
            <td>
              <input name="name" class="w-96 input input-bordered" type="text" placeholder="이름을 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td>
              <input name="email" class="w-96 input input-bordered" type="email" placeholder="이메일를 입력해주세요." />
            </td>
          </tr>
          <tr>
            <th>아이디 찾기</th>
            <td>
              <button type="submit" class="btn btn-primary">아이디 찾기</button>
              <button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
    <a class="btn btn-link" href="../member/join">회원가입</a>
    <a class="btn btn-link" href="../member/findLoginPw">비밀번호 찾기</a>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>