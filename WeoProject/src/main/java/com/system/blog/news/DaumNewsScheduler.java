package com.system.blog.news;


import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class DaumNewsScheduler {

    @Autowired
    private DaumNewsMapper mapper;

    public void scrawal() throws Exception {
        String url = "https://news.daum.net/";
        Connection conn = Jsoup.connect(url);
        Document document = conn.get();

        final Elements news_list = document.select(".item_issue");
        final Elements thumbnailElem = document.select(".item_issue > a > img");
        final Elements linkElem = document.select(".item_issue > a");
        final Elements titleElem = document.select(".item_issue .tit_g > .link_txt");
        final Elements companyElem = document.select(".logo_cp > .thumb_g");
        final Elements categoryElem = document.select(".txt_category");

        final int size = news_list.size();
        List<NewsVO> data = new ArrayList<>();

        for (int i = 0; i < size; i++) {
            try {
                String thumbnail = getElementSource(thumbnailElem, i);
                String link = getElementLink(linkElem, i);
                String title = getElementText(titleElem, i);
                String newspaper = getElementAlt(companyElem, i);
                String category  = getElementText(categoryElem, i);
                String id = link.split("/")[4];

                Connection conn1 = Jsoup.connect(link);
                Document document1 = conn1.get();

                Elements contentsElem = document1.select("#harmonyContainer p");
                Elements reportElem = document1.select("span.txt_info");
                Elements thumbnailEleme = document1.select("figure.origin_fig img");

                int size1 = contentsElem.size();
                String title_contents = "";
                for (int ii = 0; ii < size1; ii++) {
                    title_contents += getElementText(contentsElem, ii) + "\n";
                }
//                String title_contents = getElementText(contentsElem, 0);
                String reporter = getElementText(reportElem, 0);
                String titleThumbnail = getElementSource(thumbnailEleme, 0);

                NewsVO newsVO = new NewsVO();
                newsVO.setId(id);
                newsVO.setThumbnail(titleThumbnail);
                newsVO.setSummary("summary");
                newsVO.setTitle_name(title);
//                newsVO.setTitle_thumbnail(titleThumbnail);
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

        mapper.batchInsert(data);



//        String COLLECTION = "news";
//
//        Firestore db = FirestoreClient.getFirestore();
//        for (NewsVO datum : data) {
//            db.collection(COLLECTION).document(datum.getId()).set(datum);
//        }


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