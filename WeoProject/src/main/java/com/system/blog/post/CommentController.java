package com.system.blog.post;

import com.system.blog.Idgenerator;
import com.system.blog.ResponseVO;
import com.system.blog.config.Login;
import com.system.blog.post.mapper.CommentMapper;
import com.system.blog.post.vo.CommentVO;
import com.system.blog.user.vo.LoginVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping(value = "comment")
public class CommentController {

    @Autowired
    private CommentMapper commentMapper;

    @GetMapping("list/{postId}")
    private String list(@PathVariable("postId") String postId, Model model) {
    	
    	Assert.hasText(postId, "게시글 번호가 없습니다");
    	
        List<CommentVO> comments = commentMapper.list(postId);
        model.addAttribute("comments", comments);
        model.addAttribute("postId", postId);
        
        return "post/comment";
    }

    @PostMapping("insertProcess/{postId}")
    private ResponseEntity insertProcess(@RequestBody CommentVO commentVO, @Login LoginVO loginVO) {
    	
    	commentVO.setUserId(loginVO.getUserId());
    	commentVO.setId(Idgenerator.getId());
        
    	int row = commentMapper.insertProcess(commentVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    @DeleteMapping("deleteProcess/{postId}/{commentId}")
    private ResponseEntity deleteProcess(@Login LoginVO loginVO, @PathVariable("postId") String postId, @PathVariable("commentId") String commentId) {
        EgovMap map = new EgovMap();
        map.put("postId", postId);
        map.put("commentId", commentId);
        map.put("userId", loginVO.getUserId());
        int row = commentMapper.deleteProcess(map);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

}
