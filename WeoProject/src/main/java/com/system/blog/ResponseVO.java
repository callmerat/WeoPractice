package com.system.blog;

public class ResponseVO {

    private String msg;

    public ResponseVO() {}

    public ResponseVO(String msg) {
        this.msg = msg;
    }

    public static ResponseVO of(String msg) {
        return new ResponseVO(msg);
    }

    public String getMsg() {
        return msg;
    }

}
