package com.projetannuel.userapi.entities;

import com.projetannuel.userapi.IdClass.MediaId;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Column;
import java.io.Serializable;

/**
 * The type Media.
 */
@Entity
@IdClass(MediaId.class)
@Table(name = "MEDIA")
public class Media implements Serializable {
    /**
     * media identifier.
     */
    @Id
    @Column(name = "IDMEDIA")
    private String idMedia;

    /**
     * media type.
     */
    @Id
    @Column(name = "MEDIATYPE")
    private String mediaType;

    /**
     * Instantiates a new Media.
     *
     * @param idMedia   the id media
     * @param mediaType the media type
     */
    public Media(final String idMedia, final String mediaType) {
        this.idMedia = idMedia;
        this.mediaType = mediaType;
    }

    /**
     * Instantiates a new Media.
     */
    public Media() {

    }

    /**
     * Gets id media.
     *
     * @return the id media
     */
    public String getIdMedia() {
        return idMedia;
    }

    /**
     * Sets id media.
     *
     * @param idMedia the id media
     */
    public void setIdMedia(final String idMedia) {
        this.idMedia = idMedia;
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
}
