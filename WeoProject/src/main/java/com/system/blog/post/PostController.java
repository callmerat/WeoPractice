package com.system.blog.post;

import com.system.blog.Idgenerator;
import com.system.blog.ResponseVO;
import com.system.blog.config.Login;
import com.system.blog.post.mapper.CategoryMapper;
import com.system.blog.post.mapper.PostMapper;
import com.system.blog.post.vo.PostVO;
import com.system.blog.user.vo.LoginVO;
import com.system.blog.user.vo.UserVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping(value = "post")
public class PostController {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @GetMapping(value = "write.do")
    private String write(@Login LoginVO loginVO, String postId, Model model) {

        if (Objects.nonNull(postId)) {
            PostVO post = postMapper.getPost(postId);
            model.addAttribute("post", post);
        }
        List<EgovMap> category = categoryMapper.getList(loginVO.getUserId());
        model.addAttribute("category", category);

        return "post/write";
    }

    @GetMapping(value = "list.do")
    private String list(Model model) {
        List<PostVO> posts = postMapper.getSearch();
        model.addAttribute("posts", posts);
        return "post/list";
    }


    @GetMapping(value = "view.do")
    private String view(Model model, @RequestParam("postId") String postId) {
        PostVO post = postMapper.getPost(postId);
        model.addAttribute("post", post);
        return "post/view";
    }

    @PostMapping(value = "writeProcess")
    private ResponseEntity writeProcess(@Login LoginVO loginVO, @RequestBody PostVO postVO) {

        postVO.setId(Idgenerator.getId());
        postVO.setUserId(loginVO.getUserId());
        int row = postMapper.writeProcess(postVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    @PutMapping(value = "upateProcess/{id}")
    private ResponseEntity updateProcess(@Login LoginVO loginVO, @RequestBody PostVO postVO, @PathVariable("id") String id) {
        postVO.setUserId(loginVO.getUserId());
        int row = postMapper.updateProcess(postVO);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }

    @DeleteMapping(value = "deleteProcess/{id}")
    private ResponseEntity deleteProcess(@PathVariable("id") String id) {
        int row = postMapper.deleteProcess(id);
        return ResponseEntity.ok().body(ResponseVO.of("ok"));
    }
}
