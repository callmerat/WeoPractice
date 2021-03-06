package com.system.blog.excel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.blog.excel.mapper.ExcelMapper;
import com.system.blog.excel.vo.ExcelVO;

import java.util.List;

@Service
public class ExcelService {

    @Autowired
    private ExcelMapper mapper;

    public List<ExcelVO> list() {
        return mapper.list();
    }

}
