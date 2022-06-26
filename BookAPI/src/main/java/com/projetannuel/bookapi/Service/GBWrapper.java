package com.projetannuel.bookapi.Service;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)

public class GBWrapper {

    private int totalItems;
    private GBItemsWrapper[] items;


    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public GBItemsWrapper[] getItems() {
        return items;
    }

    public void setItems(GBItemsWrapper[] items) {
        this.items = items;
    }
}
