package com.projetannuel.userapi.IdClass;

import com.fasterxml.jackson.annotation.JsonRawValue;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.Serializable;

public class UserMediaId implements Serializable
{
    private Integer idUser;
    private String idMedia;

    private String mediaType;

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
}