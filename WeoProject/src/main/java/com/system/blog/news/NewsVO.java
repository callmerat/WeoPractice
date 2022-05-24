package com.system.blog.news;


import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@Data
public class NewsVO {

    private String id;
    private String reg_date;
    private int category_id;
    private String thumbnail;
    private String summary;
    private String title_thumbnail;
    private String title_name;
    private String title_contents;
    private String reporter;
    private String newspaper;
    private String open_yn;
    private int view_count;
    private String link;

    public String getReg_date() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Calendar c1 = Calendar.getInstance();
        return sdf.format(c1.getTime());
    }
}
