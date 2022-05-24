package com.system.blog.config;

public class NoDataException extends RuntimeException {
    private String msg;

    public NoDataException() {}
    public NoDataException(String m) {
        this.msg = m;
    }
}
