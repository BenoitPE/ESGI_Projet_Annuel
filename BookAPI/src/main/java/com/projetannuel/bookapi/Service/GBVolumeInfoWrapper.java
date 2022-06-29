package com.projetannuel.bookapi.Service;

import java.util.HashMap;
import java.util.Map;

public class GBVolumeInfoWrapper {

    private String title;
    private String publisher;
    private String publishedDate;
    private String[] authors;
    private Map<String, String> imageLinks = new HashMap<String, String>();


    private String description;
    private int pageCount;
    private int printType;
    private String[] categories;
    private String language;

    public String getTitle() {
        return title;
    }

    public String getPublisher() {
        return publisher;
    }

    public String getPublishedDate() {
        return publishedDate;
    }

    public String[] getAuthors() {
        return authors;
    }

    public Map<String, String> getImageLinks() {
        return imageLinks;
    }


}
