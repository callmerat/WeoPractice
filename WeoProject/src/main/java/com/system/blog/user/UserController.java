package com.system.blog.user;


import com.system.blog.ResponseVO;
import com.system.blog.user.mapper.UserMapper;
import com.system.blog.user.vo.LoginVO;
import com.system.blog.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping(value = "user")
public class UserController {

    @Autowired
    private UserMapper userMapper;


    @PostMapping(value = "registrationProcess")
    private ResponseEntity registrationProcess(@Validated @RequestBody UserVO userVO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            throw new RuntimeException("오류 !!!");
        }
        int row = userMapper.registrationProcess(userVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    @GetMapping(value = "logout.do")
    private String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        if (loginVO != null) {
            session.invalidate();
        }
        return "user/login";
    }


    @GetMapping(value = "login.do")
    private String login() {
        return "user/login";
    }

    @PostMapping(value = "loginProcess")
    private ResponseEntity loginProcess(HttpServletRequest request, @RequestBody UserVO userVO) {
        UserVO user = userMapper.login(userVO);
        LoginVO loginVO = new LoginVO();
        HttpSession session = request.getSession();
        if (user != null) {
            loginVO.setUserId(user.getUserId());
            loginVO.setEmail(user.getEmail());
            loginVO.setName(user.getName());
        } else {
            throw new RuntimeException("login failed");
        }
        session.setAttribute("loginVO", loginVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    @GetMapping(value = "registation.do")
    private String registration() {
        return "user/registration";
    }

}
