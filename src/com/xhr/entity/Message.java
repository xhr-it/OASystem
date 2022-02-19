package com.xhr.entity;

public class Message {
    private boolean state;
    private String message;

    public Message(boolean state, String message) {
        this.state = state;
        this.message = message;
    }

    public boolean getState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
