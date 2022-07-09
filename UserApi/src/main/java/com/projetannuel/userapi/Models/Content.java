package com.projetannuel.userapi.Models;

import com.fasterxml.jackson.annotation.JsonRawValue;

public class Content
{
    @JsonRawValue
    private Object body;

    public Content(Object body) {
        this.body = body;
    }

    public Object getBody() {
        return body;
    }

    public void setBody(Object body) {
        this.body = body;
    }
}