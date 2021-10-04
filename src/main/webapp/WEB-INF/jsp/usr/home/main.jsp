<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf"%>

<section class="mt-5">
 <div class="px-4 py-4">
        <div class="flex items-center w-full px-4 py-10 bg-cover card bg-base-200"
          style="background-image: url(&quot;https://picsum.photos/id/180/1000/300&quot;);">
          <div class="card glass lg:card-side text-neutral-content">
            <figure class="p-6">
              <img src="https://picsum.photos/id/160/300/200" class="rounded-lg shadow-lg">
            </figure>
            <div class="max-w-md card-body">
              <h2 class="card-title_1">Cho</h2>
              <p>해당 프로젝트는 JAVA 기반으로 MVC구조의 커뮤니티 사이트 이며, 개인 프로젝트 입니다.</p>
              <p>회원가입을 통해 자유롭게 이용할 수 있도록 구현하였습니다.</p>
              <div class="card-actions">
              </div>
            </div>
          </div>
        </div>
      </div>
</section>

<%@ include file="../common/foot.jspf"%>