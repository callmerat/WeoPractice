package com.system.blog.config;

public class MyLoginException extends RuntimeException {
    private String msg;

    public MyLoginException() {}
    public MyLoginException(String m) {
        this.msg = m;
    }

}
