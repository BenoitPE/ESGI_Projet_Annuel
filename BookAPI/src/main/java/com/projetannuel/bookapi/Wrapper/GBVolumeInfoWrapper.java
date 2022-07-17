package com.projetannuel.bookapi.Wrapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GBVolumeInfoWrapper {

    private String title;
    private String publisher;
    private String publishedDate;
    private String[] authors;
    private final Map<String, String> imageLinks = new HashMap<String, String>();
    private String description;
    private String maturityRating;
    private String pageCount;
    private List<IndustryIdentifiers> industryIdentifiers;

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

    public String getDescription() { return description; }

    public String getMaturityRating() { return maturityRating; }

    public String getPageCount() { return pageCount; }

    public List<IndustryIdentifiers> getIndustryIdentifiers() {
        return industryIdentifiers;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPublisher(String publisher) { this.publisher = publisher; }

    public void setPublishedDate(String publishedDate) {
        this.publishedDate = publishedDate;
    }

    public void setAuthors(String[] authors) {
        this.authors = authors;
    }

    public void setDescription(String description) { this.description = description; }

    public void setMaturityRating(String maturityRating) { this.maturityRating = maturityRating; }

    public void setPageCount(String pageCount) { this.pageCount = pageCount; }

    public void setIndustryIdentifiers(List<IndustryIdentifiers> industryIdentifiers) {
        this.industryIdentifiers = industryIdentifiers;
    }
}
