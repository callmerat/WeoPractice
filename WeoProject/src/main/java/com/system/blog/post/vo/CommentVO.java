package com.system.blog.post.vo;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class CommentVO {

    private String id;
    private String commentText;
    private Timestamp regDate;
    private String postId;
    private String userId;

}
