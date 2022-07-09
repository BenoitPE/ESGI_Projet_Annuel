package com.projetannuel.bookapi.Wrapper;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)
public class GBItemsWrapper {

    private GBVolumeInfoWrapper volumeInfo;
    private String id;

    public GBVolumeInfoWrapper getVolumeInfo() {
        return volumeInfo;
    }

    public void setVolumeInfo(GBVolumeInfoWrapper volumeInfo) {
        this.volumeInfo = volumeInfo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
