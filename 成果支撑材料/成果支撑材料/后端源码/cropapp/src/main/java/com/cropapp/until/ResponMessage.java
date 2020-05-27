package com.cropapp.until;

public class ResponMessage<T> {
    private int code;
    private String message;
    private T data;

    public ResponMessage<T> setCode(StateCode stateCode) {
        this.code = stateCode.getCode();

        return this;
    }

    public int getCode() {
        return code;
    }

    public ResponMessage<T> setCode(int code) {
        this.code = code;

        return this;
    }

    public String getMessage() {
        return message;
    }

    public ResponMessage<T> setMessage(String message) {
        this.message = message;

        return this;
    }

    public T getData() {
        return data;
    }

    public ResponMessage<T> setData(T data) {
        this.data = data;

        return this;
    }
}
