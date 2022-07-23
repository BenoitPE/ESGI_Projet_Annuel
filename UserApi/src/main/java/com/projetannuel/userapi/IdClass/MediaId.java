package com.projetannuel.userapi.IdClass;

import java.io.Serializable;

public class MediaId implements Serializable
{
    private String idMedia;
    private String mediaType;

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    public String getIdMedia() {
        return idMedia;
    }

    public void setIdMedia(String idMedia) {
        this.idMedia = idMedia;
    }
}