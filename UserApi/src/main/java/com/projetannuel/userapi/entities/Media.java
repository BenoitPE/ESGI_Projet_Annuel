package com.projetannuel.userapi.entities;
import com.projetannuel.userapi.IdClass.MediaId;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(MediaId.class)
@Table(name = "MEDIA")
public class Media implements Serializable {
    @Id @Column(name = "IDMEDIA")
    private String idMedia;
    @Id @Column(name = "MEDIATYPE")
    private String mediaType;

    public Media(String idMedia, String mediaType) {
        this.idMedia = idMedia;
        this.mediaType = mediaType;
    }

    public Media() {

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
}