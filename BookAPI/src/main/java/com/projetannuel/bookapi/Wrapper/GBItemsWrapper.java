package com.projetannuel.bookapi.Wrapper;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.projetannuel.bookapi.Service.GBVolumeInfoWrapper;

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
