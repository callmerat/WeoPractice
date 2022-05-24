package com.system.blog.user.vo;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;


@Getter
@Setter
@NoArgsConstructor
public class UserVO {

    private String userId;

    @NotNull(message = "Please provide a author")
    private String name;

    @NotEmpty(message = "Please provide a author")
    private String passwd;

    @Phone
    @NotNull(message = "email is not null")
    private String email;

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", name=" + name + ", email=" + email + "]";
	}
    
    
    

}
