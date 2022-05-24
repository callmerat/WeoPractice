package com.system.blog.news;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.system.blog.ExcelUtils;
import com.system.blog.config.NoDataException;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(value = "news")
@Controller
public class DaumNewsExcelController {

    @Autowired
    private DaumNewsMapper daumNewsMapper;

    @Autowired
    ResourceLoader resourceLoader;

    @GetMapping(value = "/download")
    private void news_download(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Resource resource = null;
        resource = resourceLoader.getResource("classpath:excelTemplate/ExcelTemplate.xlsx");

        if (resource == null) {
            throw new NoDataException("Excel template doesn't exist");
        }

        String downloadFileName = "daum_news.xlsx";

        List<NewsVO> news = daumNewsMapper.getNews();
        Map beans = new HashMap();
        beans.put("news", news);

        ExcelUtils.downloadExcel(request, response, beans, resource, downloadFileName);
    }


    @PostMapping("/upload")
    private ResponseEntity
    fitsizeUpload(@RequestBody MultipartFile fileObject) throws IOException {

        String[] colNames = {
                "id",
                "reg_date",
                "category_id",
                "thumbnail",
                "summary",
                "title_name",
                "title_contents",
                "reporter",
                "newspaper",
                "open_yn",
                "view_count",
                "link"
        };

        if (fileObject == null) {
            throw new NoDataException("Excel file doesn't exist");
        }
        String extension = StringUtils.getFilenameExtension(fileObject.getOriginalFilename());
        if (!"xlsx".equals(extension)) {
            throw new NoDataException("invalid Excel format file");
        }


        List<EgovMap> pubMaps = null;
        try {
            pubMaps = ExcelUtils.xlsx_excelFileUpload(
                    fileObject,
                    Arrays.asList(colNames));

        } catch (IOException e) {
            throw new NoDataException("Excel upload Failed");
        }

        daumNewsMapper.batchInsert2(pubMaps);

        return ResponseEntity.ok(pubMaps);
    }
}
