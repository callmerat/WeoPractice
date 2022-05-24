package com.system.blog.news;

import com.system.blog.config.PageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

public interface DaumNewsMapper {

    List<NewsVO> getNews();

    List<NewsVO> getAllNews(PageVO pageVO);

    NewsVO detailNews(String id);

    List<EgovMap> getCategory();

    int createNews(NewsVO newsVO);

    int updateNews(NewsVO newsVO);

    int countAllNews();

    void batchInsert(List<NewsVO> data);

    void batchInsert2(List<EgovMap> data);

}
