package com.system.blog.news.naver;

import com.system.blog.config.PageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

public interface NaverNewsMapper {

    List<NewsVONaver> getNewsNaver();

    List<NewsVONaver> getAllNewsNaver(PageVO pageVO);

    NewsVONaver detailNewsNaver(String id);

    List<EgovMap> getCategoryNaver();

    int createNewsNaver(NewsVONaver newsVO);

    int updateNewsNaver(NewsVONaver newsVO);

    int countAllNewsNaver();

    void batchInsertNaver(List<NewsVONaver> data);

    void batchInsert2Naver(List<EgovMap> data);

}
