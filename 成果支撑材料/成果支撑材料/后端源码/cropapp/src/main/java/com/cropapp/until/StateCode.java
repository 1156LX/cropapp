package com.cropapp.until;

public enum StateCode {
    SUCCESS(200),
    FAILURE(400),
    NOTFOUND(404);

    private int code;

    StateCode(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
