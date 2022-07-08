package com.projetannuel.userapi.entities;
import javax.persistence.*;
@Entity
@Table(name = "USER")
public class User {
    @Id @Column(name = "IdUser") @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idUser;
    @Column(name = "username")
    private String username;
    @Column(name = "email")
    private String email;
    @Column(name = "password")
    private String password;

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer IdUser) {
        idUser = IdUser;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
            this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}