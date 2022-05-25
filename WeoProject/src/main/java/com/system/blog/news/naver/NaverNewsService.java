package com.system.blog.news.naver;


import com.system.blog.config.PageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NaverNewsService {

    @Autowired
    private NaverNewsMapper mapper;

    public List<NewsVONaver> getNewsNaver() {
        return mapper.getNewsNaver();
    }

    public List<NewsVONaver> getAllNewsNaver(PageVO pageVO) {
        return mapper.getAllNewsNaver(pageVO);
    }

    public NewsVONaver detailNewsNaver(String id) {
        return mapper.detailNewsNaver(id);
    }

    public List<EgovMap> getCategoryNaver() {
        return mapper.getCategoryNaver();
    }

    public int createNewsNaver(NewsVONaver newsVO) {
        return mapper.createNewsNaver(newsVO);
    }

    public int updateNewsNaver(NewsVONaver newsVO) {
        return mapper.updateNewsNaver(newsVO);
    }

    public int countAllNews() {
        return mapper.countAllNewsNaver();
    }

}
