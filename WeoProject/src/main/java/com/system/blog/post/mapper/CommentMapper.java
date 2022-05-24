package com.system.blog.post.mapper;

import com.system.blog.post.vo.CommentVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

public interface CommentMapper {
    List<CommentVO> list(String postId);

    int insertProcess(CommentVO commentVO);

    int deleteProcess(EgovMap map);

}
