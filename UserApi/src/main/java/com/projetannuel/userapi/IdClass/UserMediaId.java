package com.projetannuel.userapi.IdClass;

import java.io.Serializable;

/**
 * The type User media id.
 */
public class UserMediaId implements Serializable {
    /**
     * user identifier.
     */
    private Integer idUser;

    /**
     * media identifier.
     */
    private String idMedia;

    /**
     * media type.
     */
    private String mediaType;

    /**
     * Gets id user.
     *
     * @return the id user
     */
    public Integer getIdUser() {
        return idUser;
    }

    /**
     * Sets id user.
     *
     * @param idUser the id user
     */
    public void setIdUser(final Integer idUser) {
        this.idUser = idUser;
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
