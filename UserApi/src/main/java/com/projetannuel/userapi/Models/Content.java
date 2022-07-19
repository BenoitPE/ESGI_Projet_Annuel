package com.projetannuel.userapi.Models;

import com.fasterxml.jackson.annotation.JsonRawValue;
import org.json.JSONException;
import org.json.JSONObject;

public class Content
{
    private String id;
    private String title;
    private String imageUrl;
    private String date;
    private Boolean adult;
    private String overview;
    private String mediaType;
    @JsonRawValue
    private Object properties;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Boolean getAdult() {
        return adult;
    }

    public void setAdult(Boolean adult) {
        this.adult = adult;
    }

    public String getOverview() {
        return overview;
    }

    public void setOverview(String overview) {
        this.overview = overview;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    public Content(Object properties) {
        this.properties = properties;
    }

    public Object getProperties() {
        return properties;
    }

    public void setProperties(Object properties) {
        this.properties = properties;
    }

    public Content() {

    }

    public Content(String str) {
        if(null != str) {
            try {
                JSONObject json = new JSONObject(str);
                this.parse(json);
            } catch (JSONException ignored) {
                this.setNull();
            }
        }else {
            this.setNull();
        }
    }

    private void setNull(){
        this.id = null;
        this.title = null;
        this.imageUrl = null;
        this.date = null;
        this.adult = null;
        this.overview = null;
        this.mediaType = null;
        this.properties = null;
    }

    public void parse(JSONObject json){
        try {
            this.setId(json.getString("id"));
            this.setTitle(json.getString("title"));
            this.setImageUrl(json.getString("imageUrl"));
            this.setDate(json.getString("date"));
            this.setAdult(json.getBoolean("adult"));
            this.setOverview(json.getString("overview"));
            this.setMediaType(json.getString("mediaType"));
            this.setProperties(json.getJSONObject("properties"));
        }catch (JSONException ignored){
            this.setNull();
        }
    }
}