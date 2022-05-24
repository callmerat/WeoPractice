package com.system.blog.config;

public class MyApiLoginException extends RuntimeException {
    private String msg;

    public MyApiLoginException() {}
    public MyApiLoginException(String m) {
        this.msg = m;
    }
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
    
    
}
