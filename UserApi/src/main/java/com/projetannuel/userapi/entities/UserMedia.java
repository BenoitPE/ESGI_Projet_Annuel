package com.projetannuel.userapi.entities;
import com.projetannuel.userapi.IdClass.UserMediaId;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(UserMediaId.class)
@Table(name = "USERMEDIA")
public class UserMedia implements Serializable {
    @Id @Column(name = "IDUSER")
    private Integer idUser;
    @Id @Column(name = "IDMEDIA")
    private String idMedia;
    @Id @Column(name = "MEDIATYPE")
    private String mediaType;
    @Column(name = "COLLECTION")
    private Boolean collection;
    @Column(name = "WISHLIST")
    private Boolean wishlist;

    public UserMedia(Integer idUser, String idMedia, String mediaType, Boolean collection, Boolean wishlist) {
        this.idUser = idUser;
        this.idMedia = idMedia;
        this.mediaType = mediaType;
        this.collection = collection;
        this.wishlist = wishlist;
    }

    public UserMedia() {

    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }

    public String getIdMedia() {
        return idMedia;
    }

    public void setIdMedia(String idMedia) {
        this.idMedia = idMedia;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    public Boolean getCollection() {
        return collection;
    }

    public void setCollection(Boolean collection) {
        this.collection = collection;
    }

    public Boolean getWishlist() {
        return wishlist;
    }

    public void setWishlist(Boolean wishlist) {
        this.wishlist = wishlist;
    }
}