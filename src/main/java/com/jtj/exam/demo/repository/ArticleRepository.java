package com.jtj.exam.demo.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.jtj.exam.demo.vo.Article;

@Component
public class ArticleRepository {
	private int articlesLastId;
	private List<Article> articles;

	public ArticleRepository() {
		articlesLastId = 0;
		articles = new ArrayList<>();
	}

	public void makeTestData() {
		for (int i = 0; i < 10; i++) {
			String title = "제목" + (i + 1);
			String body = "내용" + (i + 1);

			writeArticle(title, body);
		}
	}

	public Article getArticle(int id) {
		for (Article article : articles) {
			if (article.getId() == id) {
				return article;
			}
		}

		return null;

	}

	public void deleteArticle(int id) {
		Article article = getArticle(id);

		articles.remove(article);
	}

	public void modifyArticle(int id, String title, String body) {
		Article article = getArticle(id);

		article.setTitle(title);
		article.setBody(body);
	}

	public Article writeArticle(String title, String body) {
		int id = articlesLastId + 1;

		Article article = new Article(id, title, body);

		articles.add(article);
		articlesLastId = id;

		return article;
	}

	public List<Article> articles() {
		return articles;
	}
}
