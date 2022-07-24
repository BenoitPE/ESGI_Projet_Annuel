package com.projetannuel.userapi.Models;

import com.fasterxml.jackson.annotation.JsonRawValue;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * The type Content.
 */
public class Content {
    /**
     * content id.
     */
    private String id;

    /**
     * content title.
     */
    private String title;

    /**
     * url of the cover image.
     */
    private String imageUrl;

    /**
     * content release date.
     */
    private String date;

    /**
     * true if the content is for adult.
     */
    private Boolean adult;

    /**
     * content overview.
     */
    private String overview;

    /**
     * media type.
     */
    private String mediaType;

    /**
     * custom properties for each media type.
     */
    @JsonRawValue
    private Object properties;

    /**
     * Instantiates a new Content.
     *
     * @param properties the properties
     */
    public Content(final Object properties) {
        this.properties = properties;
    }

    /**
     * Instantiates a new Content.
     */
    public Content() {

    }

    /**
     * Instantiates a new Content.
     *
     * @param str the str
     */
    public Content(final String str) {
        if (null != str) {
            try {
                JSONObject json = new JSONObject(str);
                this.parse(json);
            } catch (JSONException ignored) {
                this.setNull();
            }
        } else {
            this.setNull();
        }
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * Sets id.
     *
     * @param id the id
     */
    public void setId(final String id) {
        this.id = id;
    }

    /**
     * Gets title.
     *
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets title.
     *
     * @param title the title
     */
    public void setTitle(final String title) {
        this.title = title;
    }

    /**
     * Gets image url.
     *
     * @return the image url
     */
    public String getImageUrl() {
        return imageUrl;
    }

    /**
     * Sets image url.
     *
     * @param imageUrl the image url
     */
    public void setImageUrl(final String imageUrl) {
        this.imageUrl = imageUrl;
    }

    /**
     * Gets date.
     *
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * Sets date.
     *
     * @param date the date
     */
    public void setDate(final String date) {
        this.date = date;
    }

    /**
     * Gets adult.
     *
     * @return the adult
     */
    public Boolean getAdult() {
        return adult;
    }

    /**
     * Sets adult.
     *
     * @param adult the adult
     */
    public void setAdult(final Boolean adult) {
        this.adult = adult;
    }

    /**
     * Gets overview.
     *
     * @return the overview
     */
    public String getOverview() {
        return overview;
    }

    /**
     * Sets overview.
     *
     * @param overview the overview
     */
    public void setOverview(final String overview) {
        this.overview = overview;
    }

    /**
     * Gets media type.
     *
     * @return the media type
     */
    public String getMediaType() {
        return mediaType;
    }

    /**
     * Sets media type.
     *
     * @param mediaType the media type
     */
    public void setMediaType(final String mediaType) {
        this.mediaType = mediaType;
    }

    /**
     * Gets properties.
     *
     * @return the properties
     */
    public Object getProperties() {
        return properties;
    }

    /**
     * Sets properties.
     *
     * @param properties the properties
     */
    public void setProperties(final Object properties) {
        this.properties = properties;
    }

    private void setNull() {
        this.id = null;
        this.title = null;
        this.imageUrl = null;
        this.date = null;
        this.adult = null;
        this.overview = null;
        this.mediaType = null;
        this.properties = null;
    }

    /**
     * Parse.
     *
     * @param json the json
     */
    public void parse(final JSONObject json) {
        try {
            this.setId(json.getString("id"));
            this.setTitle(json.getString("title"));
            this.setImageUrl(json.getString("imageUrl"));
            this.setDate(json.getString("date"));
            this.setAdult(json.getBoolean("adult"));
            this.setOverview(json.getString("overview"));
            this.setMediaType(json.getString("mediaType"));
            this.setProperties(json.getJSONObject("properties"));
        } catch (JSONException ignored) {
            this.setNull();
        }
    }
}
