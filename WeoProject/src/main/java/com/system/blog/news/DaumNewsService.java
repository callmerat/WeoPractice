package com.system.blog.news;


import com.system.blog.config.PageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DaumNewsService {


    @Autowired
    private DaumNewsMapper mapper;

    public List<NewsVO> getNews() {
        return mapper.getNews();
    }


    public List<NewsVO> getAllNews(PageVO pageVO) {
        return mapper.getAllNews(pageVO);
    }

    public NewsVO detailNews(String id) {
        return mapper.detailNews(id);
    }

    public List<EgovMap> getCategory() {
        return mapper.getCategory();
    }

    public int createNews(NewsVO newsVO) {
        return mapper.createNews(newsVO);
    }

    public int updateNews(NewsVO newsVO) {
        return mapper.updateNews(newsVO);
    }


    public int countAllNews() {
        return mapper.countAllNews();
    }

}
