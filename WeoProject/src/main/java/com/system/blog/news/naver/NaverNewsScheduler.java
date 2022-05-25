package com.system.blog.news.naver;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NaverNewsScheduler {

    @Autowired
    private NaverNewsMapper mapper;

    public void naver_scrawal() throws Exception {
        String url = "https://news.naver.com/main/ranking/popularDay.naver";
        Connection conn = Jsoup.connect(url);
        Document document = conn.get();

        final Elements news_list = document.select(".list_content");
        final Elements thumbnailElem = document.select(".list_content > a > img");
        final Elements linkElem = document.select(".list_content > a");
        final Elements titleElem = document.select(".list_content > a");
        final Elements companyElem = document.select(".rankingnews_thumb > img");

        final int size = news_list.size();
        List<NewsVONaver> data = new ArrayList<>();

        for (int i = 0; i < size; i++) {
            try {
                String thumbnail = getElementSource(thumbnailElem, i);
                String link = getElementLink(linkElem, i);
                String title = getElementText(titleElem, i);
                String newspaper = getElementAlt(companyElem, i);
                String id = link.split("/")[4]; // 앞에 004 이런 번호
                String id2 = link.split("/")[5].split("?")[0]; // 뒤에 일련번호

                // 링크 접속
                Connection conn1 = Jsoup.connect(link);
                Document document1 = conn1.get();

                Elements contentsElem = document1.select("#dic_area span"); // 내용
                Elements reportElem = document1.select(".media_end_head_journalist_name"); // 기자 이름
                Elements thumbnailEleme = document1.select("#img_a1 img"); // 썸네일 이미지

                int size1 = contentsElem.size();
                String title_contents = "";
                for (int ii = 0; ii < size1; ii++) {
                    title_contents += getElementText(contentsElem, ii) + "\n";
                }
//                String title_contents = getElementText(contentsElem, 0);
                String reporter = getElementText(reportElem, 0);
                String titleThumbnail = getElementSource(thumbnailEleme, 0);

                NewsVONaver newsVO = new NewsVONaver();
                newsVO.setId(id);
                newsVO.setThumbnail(titleThumbnail);
                newsVO.setSummary("summary");
                newsVO.setTitle_name(title);
                newsVO.setTitle_contents(title_contents);
                newsVO.setReporter(reporter);
                newsVO.setOpen_yn("y");
                newsVO.setView_count(0);
                newsVO.setNewspaper(newspaper);
                newsVO.setLink(link);
                data.add(newsVO);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        System.out.println("finished = ");

        mapper.batchInsertNaver(data);

    }

    private static String getElementAlt(Elements elements, int index) {
        return elements.get(index).attr("alt");
    }

    private static String getElementText(Elements elements, int index) {
        return elements.get(index).text();
    }

    private static String getElementSource(Elements elements, int index) {
        return elements.get(index).attr("src");
    }
    
    private static String getElementLink(Elements elements, int index) {
        return elements.get(index).attr("href");
    }
}