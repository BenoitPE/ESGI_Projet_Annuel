package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface User repository.
 */
@Repository
public interface UserRepository extends JpaRepository<User, String> {
    /**
     * Find by username and password user.
     *
     * @param username the username
     * @param password the password
     * @return the user
     */
    User findByUsernameAndPassword(String username, String password);

    /**
     * Find by username user.
     *
     * @param username the username
     * @return the user
     */
    User findByUsername(String username);

    /**
     * Find by id user user.
     *
     * @param idUser the id user
     * @return the user
     */
    User findByIdUser(Integer idUser);
}

