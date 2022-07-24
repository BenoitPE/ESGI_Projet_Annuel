package com.projetannuel.userapi.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * The type User.
 */
@Entity
@Table(name = "USER")
public class User {
    /**
     * user identifier.
     */
    @Id
    @Column(name = "IdUser")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idUser;

    /**
     * user username.
     */
    @Column(name = "username")
    private String username;

    /**
     * user email.
     */
    @Column(name = "email")
    private String email;

    /**
     * user password.
     */
    @Column(name = "password")
    private String password;

    /**
     * Gets id user.
     *
     * @return the id user
     */
    public Integer getIdUser() {
        return idUser;
    }

    /**
     * Sets id user.
     *
     * @param idUser the id user
     */
    public void setIdUser(final Integer idUser) {
        this.idUser = idUser;
    }

    /**
     * Gets username.
     *
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets username.
     *
     * @param username the username
     */
    public void setUsername(final String username) {
        this.username = username;
    }

    /**
     * Gets email.
     *
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets email.
     *
     * @param email the email
     */
    public void setEmail(final String email) {
        this.email = email;
    }

    /**
     * Gets password.
     *
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets password.
     *
     * @param password the password
     */
    public void setPassword(final String password) {
        this.password = password;
    }
}
