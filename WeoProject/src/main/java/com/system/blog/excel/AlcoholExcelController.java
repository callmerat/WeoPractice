package com.system.blog.excel;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.system.blog.ExcelUtils;
import com.system.blog.config.NoDataException;
import com.system.blog.excel.mapper.ExcelMapper;
import com.system.blog.excel.vo.ExcelVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@RequestMapping(value = "excel")
@Controller
public class AlcoholExcelController {

    @Autowired
    private ExcelMapper excelMapper;

    @Autowired
    ResourceLoader resourceLoader;

    @GetMapping(value = "/download")
    private void alcohol_download(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Resource resource = null;
        resource = resourceLoader.getResource("classpath:excelTemplate/ExcelTemplate2.xlsx");

        if (resource == null) {
            throw new NoDataException("Excel template doesn't exist");
        }

        String downloadFileName = "alcohol.xlsx";

        List<ExcelVO> excel = excelMapper.list();
        Map beans = new HashMap();
        beans.put("excel", excel);
        
        ExcelUtils.downloadExcel(request, response, beans, resource, downloadFileName);
    }

    @PostMapping("/upload")
    private ResponseEntity
    fitsizeUpload(@RequestBody MultipartFile fileObject1) throws IOException {

        String[] colNames = {
                "time",
                "age",
                "total",
                "male",
                "female"
        };

        if (fileObject1 == null) {
            throw new NoDataException("Excel file doesn't exist");
        }
        String extension = StringUtils.getFilenameExtension(fileObject1.getOriginalFilename());
        if (!"xlsx".equals(extension)) {
            throw new NoDataException("invalid Excel format file");
        }

        List<EgovMap> pubMaps = null;
        try {
            pubMaps = ExcelUtils.xlsx_excelFileUpload(
                    fileObject1,
                    Arrays.asList(colNames));

        } catch (IOException e) {
            throw new NoDataException("Excel upload Failed");
        }

        excelMapper.batchInsert2(pubMaps);

        return ResponseEntity.ok(pubMaps);
    }
}
