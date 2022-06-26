package com.projetannuel.bookapi.Service;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

public class GBVolumeInfoWrapper {

    private String title;
    private String publisher;
    private String publishedDate;
    private String[] authors;
    private String description;
    private int pageCount;
    private int printType;
    private String[] categories;
    private Map<String, String> imageLinks = new HashMap<String, String>();
    private String language;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(String publishedDate) {this.publishedDate = publishedDate;}

    public String[] getAuthors() {
        return authors;
    }

    public void setAuthors(String[] authors) {
        this.authors = authors;
    }

    public Map<String, String> getImageLinks() {
        return imageLinks;
    }

    public void setImageLinks(Map<String, String> imageLinks) {
        this.imageLinks = imageLinks;
    }
}
