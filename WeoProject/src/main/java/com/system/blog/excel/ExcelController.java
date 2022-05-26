package com.system.blog.excel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.system.blog.excel.vo.ExcelVO;

@RequestMapping(value = "excel")
@Controller
public class ExcelController {
	
	@Autowired
	private ExcelService excelService;
	
    @GetMapping(value = "excel.do")
    private String excel(Model model) {
    	
    	List<ExcelVO>list = excelService.list();
    	model.addAttribute("list", list);
        return "excel/view";
        
    }
}
