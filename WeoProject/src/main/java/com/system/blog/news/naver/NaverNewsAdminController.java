package com.system.blog.news.naver;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.system.blog.ResponseVO;
import com.system.blog.config.PageVO;
import com.system.blog.news.NewsVO;
import com.system.blog.news.naver.NaverNewsService;
import com.system.blog.news.naver.NewsVONaver;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@RequestMapping(value = "naver_news")
@Controller
public class NaverNewsAdminController {

    @Autowired
    private NaverNewsService service2;
    
    @RequestMapping(value = "/form", method = RequestMethod.GET)
    public String formNewsNaver(Model model) {
    	List<EgovMap> category2 = service2.getCategoryNaver();
    	
    	model.addAttribute("category2", category2);
    	return "naver_news/form";
    }
    

    @RequestMapping(value = "/form/{id}", method = RequestMethod.GET)
    public String formNews(@PathVariable("id") String id, Model model) {
        NewsVONaver vo2 = service2.detailNewsNaver(id);
        List<EgovMap> category2 = service2.getCategoryNaver();

        model.addAttribute("vo2", vo2);
        model.addAttribute("category2", category2);
        return "naver_news/form";
    }
    
    
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ResponseVO createNews(@RequestBody NewsVONaver newsVONaver) {
        int cnt = service2.createNewsNaver(newsVONaver);
        return ResponseVO.of("OK");
    }
    

    @RequestMapping(value = "/update", method = RequestMethod.PUT)
    public ResponseVO updateNews(@RequestBody NewsVONaver newsVONaver) {
        int cnt = service2.updateNewsNaver(newsVONaver);
        return ResponseVO.of("OK");
    }

}
