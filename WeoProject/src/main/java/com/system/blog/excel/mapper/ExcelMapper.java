package com.system.blog.excel.mapper;

import java.util.List;

import com.system.blog.excel.vo.ExcelVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ExcelMapper {
    
	List<ExcelVO> list();

    void batchInsert2(List<EgovMap> data);

}
