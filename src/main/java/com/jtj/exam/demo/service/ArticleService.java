package com.jtj.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jtj.exam.demo.repository.ArticleRepository;
import com.jtj.exam.demo.util.Ut;
import com.jtj.exam.demo.vo.Article;
import com.jtj.exam.demo.vo.ResultData;

@Service
public class ArticleService {
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public ResultData<Integer> writeArticle(int memberId, int boardId, String title, String body) {
		articleRepository.writeArticle(memberId, boardId, title, body);
		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
	}

	public List<Article> getForPrintArticles(int actorId, int boardId, String searchKeywordTypeCode, String searchKeyword, int itemsCountInApage, int page) {
		int limitStart = (page - 1) * itemsCountInApage;
		int limitTake = itemsCountInApage;

		List<Article> articles = articleRepository.getArticles(boardId, limitStart, limitTake, searchKeywordTypeCode, searchKeyword);

		for (Article article : articles) {
			updateForPrintData(actorId, article);
		}

		return articles;
	}

	public Article getForPrintArticle(int actorId, int id) {
		Article article = articleRepository.getForPrintArticle(id);

		updateForPrintData(actorId, article);

		return article;
	}

	private void updateForPrintData(int actorId, Article article) {
		if (article == null) {
			return;
		}

		ResultData actorCanDeleteRd = actorCanDelete(actorId, article);
		article.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());

		ResultData actorCanModifyRd = actorCanModify(actorId, article);
		article.setExtra__actorCanModify(actorCanModifyRd.isSuccess());
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);

		Article article = getForPrintArticle(0, id);

		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정하였습니다.", id), "article", article);
	}

	public ResultData actorCanModify(int actor, Article article) {
		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다.");
		}

		if (article.getMemberId() != actor) {
			return ResultData.from("F-2", "권한이 없습니다.");
		}

		return ResultData.from("S-1", "게시물 수정이 가능합니다.");
	}

	public ResultData actorCanDelete(int actor, Article article) {
		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다.");
		}

		if (article.getMemberId() != actor) {
			return ResultData.from("F-2", "권한이 없습니다.");
		}

		return ResultData.from("S-1", "게시물 삭제가 가능합니다.");
	}

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	public ResultData<Integer> increaseHitCount(int id) {
		int affectedRowsCount = articleRepository.increaseHitCount(id);
		
		if(affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물이 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}
		
		return ResultData.from("S-1", "조회수가 증가었습니다.", "affectedRowsCount", affectedRowsCount);
	}

	public int getArticleHitCount(int id, Object object, Object object2) {
		return articleRepository.getArticleHitCount(id);
	}

}
