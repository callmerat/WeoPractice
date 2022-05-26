package com.system.blog;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.system.blog.post.vo.PostVO;

@Controller
@RequestMapping(value = "home")
public class HomeController {
    
    @GetMapping(value = "home.do")
    private String home(Model model) {
    	return "home/home";
    }
    
    @GetMapping(value = "test.do")
    private String test(Model model) {
    	return "home/test";
    }

}
