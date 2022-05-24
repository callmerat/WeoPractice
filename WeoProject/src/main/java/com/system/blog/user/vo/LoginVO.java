package com.system.blog.user.vo;

import lombok.Data;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

@Data
public class LoginVO {

    private String userId;

    private String name;

    private String email;
}
