package com.system.blog.post.mapper;

import com.system.blog.post.vo.CategoryVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

public interface CategoryMapper {
    List<EgovMap> getList(String userId);

    int insertProcess(CategoryVO categoryVO);

    int updateProcess(CategoryVO categoryVO);

    int deleteProcess(String id);

}
