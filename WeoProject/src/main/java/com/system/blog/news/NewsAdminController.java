package com.system.blog.news;

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
import com.system.blog.news.naver.NaverNewsService;
import com.system.blog.news.naver.NewsVONaver;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@RequestMapping(value = "news")
@Controller
public class NewsAdminController {

    @Autowired
    private DaumNewsService service;

    @Autowired
    private NaverNewsService service2;
    
    @RequestMapping(value = "/news", method = RequestMethod.GET)
    public String getNewsManage(PageVO pageVO, Model model) {

    	// 다음 뉴스 전체 조회
        List<NewsVO> list = service.getAllNews(pageVO);
        int total = service.countAllNews();

        model.addAttribute("list", list);
        model.addAttribute("totalCount", total);
        
        // 네이버 뉴스 전체 조회
        List<NewsVONaver> list2 = service2.getAllNewsNaver(pageVO);
        int total2 = service2.countAllNews();
        
        model.addAttribute("list2", list2);
        model.addAttribute("totalCount2", total2);
        
        // 뷰
        return "news/list";
    }

    @RequestMapping(value = "/form1", method = RequestMethod.GET)
    public String formNews1(Model model) {
        List<EgovMap> category = service.getCategory();

        model.addAttribute("category", category);
        return "news/form1";
    }

    @RequestMapping(value = "/form", method = RequestMethod.GET)
    public String formNews(Model model) {
        List<EgovMap> category = service.getCategory();

        model.addAttribute("category", category);
        return "news/form";
    }

    @RequestMapping(value = "/form/{id}", method = RequestMethod.GET)
    public String formNews(@PathVariable("id") String id, Model model) {
        NewsVO vo = service.detailNews(id);
        List<EgovMap> category = service.getCategory();

        model.addAttribute("vo", vo);
        model.addAttribute("category", category);
        return "news/form";
    }

    @RequestMapping(value = "/popup/view/{id}", method = RequestMethod.GET)
    public String viewNews(@PathVariable("id") String id, Model model) {
        NewsVO vo = service.detailNews(id);

        model.addAttribute("vo", vo);
        return "news/view";
    }

    //----
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ResponseVO createNews(@RequestBody NewsVO newsVO) {
        int cnt = service.createNews(newsVO);
        return ResponseVO.of("OK");
    }

    @RequestMapping(value = "/update", method = RequestMethod.PUT)
    public ResponseVO updateNews(@RequestBody NewsVO newsVO) {
        int cnt = service.updateNews(newsVO);
        return ResponseVO.of("OK");
    }
}
