package com.projetannuel.userapi.entities;

import com.projetannuel.userapi.IdClass.UserMediaId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * The type User media.
 */
@Entity
@IdClass(UserMediaId.class)
@Table(name = "USERMEDIA")
public class UserMedia implements Serializable {
    /**
     * user identifier.
     */
    @Id
    @Column(name = "IDUSER")
    private Integer idUser;

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
     * true if media is in the user collection.
     */
    @Column(name = "COLLECTION")
    private Boolean collection;

    /**
     * true if media is in the user wishlist.
     */
    @Column(name = "WISHLIST")
    private Boolean wishlist;

    /**
     * Instantiates a new User media.
     *
     * @param idUser     the id user
     * @param idMedia    the id media
     * @param mediaType  the media type
     * @param collection the collection
     * @param wishlist   the wishlist
     */
    public UserMedia(final Integer idUser, final String idMedia, final String mediaType, final Boolean collection,
                     final Boolean wishlist) {
        this.idUser = idUser;
        this.idMedia = idMedia;
        this.mediaType = mediaType;
        this.collection = collection;
        this.wishlist = wishlist;
    }

    /**
     * Instantiates a new User media.
     */
    public UserMedia() {

    }

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

    /**
     * Gets collection.
     *
     * @return the collection
     */
    public Boolean getCollection() {
        return collection;
    }

    /**
     * Sets collection.
     *
     * @param collection the collection
     */
    public void setCollection(final Boolean collection) {
        this.collection = collection;
    }

    /**
     * Gets wishlist.
     *
     * @return the wishlist
     */
    public Boolean getWishlist() {
        return wishlist;
    }

    /**
     * Sets wishlist.
     *
     * @param wishlist the wishlist
     */
    public void setWishlist(final Boolean wishlist) {
        this.wishlist = wishlist;
    }
}
