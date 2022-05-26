package com.system.blog.user;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.system.blog.ResponseVO;
import com.system.blog.user.mapper.UserMapper;
import com.system.blog.user.vo.LoginVO;
import com.system.blog.user.vo.UserVO;

@Controller
@RequestMapping(value = "user")
public class UserController {

    @Autowired
    private UserMapper userMapper;

    // 회원가입 전환
    @GetMapping(value = "registation.do")
    private String registration() {
        return "user/registration";
    }

    // 회원가입
    @PostMapping(value = "registrationProcess")
    private ResponseEntity registrationProcess(@Validated @RequestBody UserVO userVO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            throw new RuntimeException("오류 !!!");
        }
        int row = userMapper.registrationProcess(userVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    // 로그인 전환
    @GetMapping(value = "login.do")
    private String login() {
        return "user/login";
    }

    // 로그인
    @PostMapping(value = "loginProcess")
    private ResponseEntity loginProcess(Model model, HttpServletRequest request, @RequestBody UserVO userVO) {
        UserVO user = userMapper.login(userVO);
        LoginVO loginVO = new LoginVO();
        HttpSession session = request.getSession();
        if (user != null) {
            loginVO.setUserId(user.getUserId());
            loginVO.setEmail(user.getEmail());
            loginVO.setName(user.getName());
            session.setAttribute("loginVO", loginVO);
        } else {
            throw new RuntimeException("login failed");
        }
        
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    // 로그아웃
    @GetMapping(value = "logout.do")
    private String logout(HttpSession session) {
        session.removeAttribute("loginVO");
        return "redirect:/home/home.do";
    }
    
}
