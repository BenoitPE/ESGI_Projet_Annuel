package com.projetannuel.userapi.entities;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "MEDIATYPE")
public class MediaType implements Serializable {
    @Id @Column(name = "NAME")
    private String name;
    @Column(name = "SERVERURL")
    private String serverUrl;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getServerUrl() {
        return serverUrl;
    }

    public void setServerUrl(String serverUrl) {
        this.serverUrl = serverUrl;
    }
}