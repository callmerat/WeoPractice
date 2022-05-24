package com.system.blog;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class HelloworldController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
    	
    	String[] alpabet = "a,b,c,d,e,f,g,h,i".split(",");
    	List<String> arr = Arrays.asList(alpabet);
    	
    	for (String string : arr) {
			System.out.println(string);
		}
        return "redirect:/post/list.do";
    }

	private String dir = "C:\\Users\\user\\Downloads\\workspaces\\springmvc-smarteditor2\\src\\main\\webapp\\blog\\";


	@RequestMapping(value = "/test123", method = RequestMethod.POST)
	public @ResponseBody
	HashMap test123(MultipartFile multipartFile) throws IOException {

		String originalFilename = multipartFile.getOriginalFilename();

		File file = new File(dir, originalFilename);
		multipartFile.transferTo(file);

		HashMap map = new HashMap();
		map.put("fileName", originalFilename);
		map.put("url", "/blog/" + originalFilename);
		return map;
	}
}
