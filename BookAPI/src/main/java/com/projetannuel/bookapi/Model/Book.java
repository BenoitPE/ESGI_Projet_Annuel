package com.projetannuel.bookapi.Model;

import java.util.Objects;

public class Book {

    public Book() {

    }

    private String id;
    private String title;
    private String imageUrl;
    private String date;
    private String adult;
    private String overview;
    private String mediaType;
    private Properties properties;

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
        if (date.length() == 4 )
        {
            date = date.concat("-01-01");
        }
        else if (date.length() == 7)
        {
            date = date.concat("-01");
        }
        this.date = date;
    }

    public String getOverview() {
        return overview;
    }

    public void setOverview(String overview) {
        this.overview = overview;
    }

    public String getAdult() {
        return adult;
    }

    public void setAdult(String adult) {
        if (Objects.equals(adult, "NOT_MATURE"))
        {
            this.adult = "false";
        }
        else
        {
            this.adult = "true";
        }
    }

    public Properties getProperties() {
        return properties;
    }

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType() {
        this.mediaType = "book";
    }

}
