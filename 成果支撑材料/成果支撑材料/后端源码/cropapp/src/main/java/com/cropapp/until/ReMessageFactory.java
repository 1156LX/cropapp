package com.cropapp.until;

public class ReMessageFactory {
    public static <T> ResponMessage<T> produceMessageSuccess(T data) {
        return new ResponMessage<T>().setCode(StateCode.SUCCESS).setMessage("请求响应成功").setData(data);
    }

    public static <T> ResponMessage<T> produceMessageSuccess(String message) {
        return new ResponMessage<T>().setCode(StateCode.SUCCESS).setMessage(message);
    }

    public static <T> ResponMessage<T> produceMessageFailure(T data) {
        return new ResponMessage<T>().setCode(StateCode.FAILURE).setMessage("请求响应失败").setData(data);
    }

    public static <T> ResponMessage<T> produceMessageFailure(String message) {
        return new ResponMessage<T>().setCode(StateCode.FAILURE).setMessage(message);
    }

    public static <T> ResponMessage<T> produceMessageNotFound(T data) {
        return new ResponMessage<T>().setCode(StateCode.NOTFOUND).setMessage("资源不存在").setData(data);
    }

    public static <T> ResponMessage<T> produceMessageNotFound(String message) {
        return new ResponMessage<T>().setCode(StateCode.NOTFOUND).setMessage(message);
    }
}
