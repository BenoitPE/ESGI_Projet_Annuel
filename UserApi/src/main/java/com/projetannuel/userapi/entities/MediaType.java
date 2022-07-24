package com.projetannuel.userapi.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * The type Media type.
 */
@Entity
@Table(name = "MEDIATYPE")
public class MediaType implements Serializable {
    /**
     * media type name.
     */
    @Id
    @Column(name = "NAME")
    private String name;

    /**
     * url of the media api.
     */
    @Column(name = "SERVERURL")
    private String serverUrl;

    /**
     * Gets name.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets name.
     *
     * @param name the name
     */
    public void setName(final String name) {
        this.name = name;
    }

    /**
     * Gets server url.
     *
     * @return the server url
     */
    public String getServerUrl() {
        return serverUrl;
    }

    /**
     * Sets server url.
     *
     * @param serverUrl the server url
     */
    public void setServerUrl(final String serverUrl) {
        this.serverUrl = serverUrl;
    }
}
