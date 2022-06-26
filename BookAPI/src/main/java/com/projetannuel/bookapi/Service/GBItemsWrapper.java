package com.projetannuel.bookapi.Service;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)
public class GBItemsWrapper {
    private GBVolumeInfoWrapper volumeInfo;

    public GBVolumeInfoWrapper getVolumeInfo() {
        return volumeInfo;
    }

    public void setVolumeInfo(GBVolumeInfoWrapper volumeInfo) {
        this.volumeInfo = volumeInfo;
    }
}
