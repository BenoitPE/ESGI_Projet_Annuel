package com.projetannuel.bookapi.Wrapper;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)

public class GBWrapper {

    private GBItemsWrapper[] items;

    public GBItemsWrapper[] getItems() {
        return items;
    }

    public void setItems(GBItemsWrapper[] items) {
        this.items = items;
    }
}
