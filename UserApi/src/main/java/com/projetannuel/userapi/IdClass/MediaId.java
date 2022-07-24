package com.projetannuel.userapi.IdClass;

import java.io.Serializable;

/**
 * The type Media id.
 */
public class MediaId implements Serializable {
    /**
     * media identifier.
     */
    private String idMedia;

    /**
     * media type.
     */
    private String mediaType;

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
}
