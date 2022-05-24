package com.system.blog.user.mapper;

import com.system.blog.user.vo.UserVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.Map;

public interface UserMapper {
    int registrationProcess(UserVO userVO);

    UserVO login(UserVO userVO);

}
