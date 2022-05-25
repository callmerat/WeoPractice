package com.system.blog;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.system.blog.user.vo.UserVO;

@Controller
public class HelloworldController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(UserVO userVO, HttpServletRequest request) {
    	
    	String[] alpabet = "a,b,c,d,e,f,g,h,i".split(",");
    	List<String> arr = Arrays.asList(alpabet);
    	
    	for (String string : arr) {
			System.out.println(string);
		}
        return "redirect:/home/home.do";
    }

}
