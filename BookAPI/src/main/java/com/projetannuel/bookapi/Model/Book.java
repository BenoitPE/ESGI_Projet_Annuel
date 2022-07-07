package com.projetannuel.bookapi.Model;

public class Book {

    public Book() {

    }

    private String id;
    private String titleContent;
    private String imageUrl;
    private String date;
    private String authorName;
    private String editorName;
    private String overview;
    private String adulte;
    private String pageCount;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitleContent() {
        return titleContent;
    }

    public void setTitleContent(String titleContent) {
        this.titleContent = titleContent;
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

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getEditorName() {
        return editorName;
    }

    public void setEditorName(String editorName) {
        this.editorName = editorName;
    }

    public String getOverview() {
        return overview;
    }

    public void setOverview(String overview) {
        this.overview = overview;
    }

    public String getAdulte() {
        return adulte;
    }

    public void setAdulte(String adulte) {
        this.adulte = adulte;
    }

    public String getPageCount() {
        return pageCount;
    }

    public void setPageCount(String pageCount) {
        this.pageCount = pageCount;
    }
}
