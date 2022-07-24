package com.projetannuel.userapi.services;

import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

/**
 * The type User service.
 */
@Service
@Transactional
public class UserService {
    /**
     * Autowire of user repository.
     */
    @Autowired
    private UserRepository userRepository;

    /**
     * Create user user.
     *
     * @param user the user
     * @return the user
     */
    public User createUser(final User user) {
        user.setEmail(user.getEmail().trim());
        user.setPassword(user.getPassword().trim());
        user.setUsername(user.getUsername().trim());

        User result = new User();

        if (userRepository.findByUsername(user.getUsername()) == null
                && (!user.getUsername().isBlank() && !user.getPassword().isBlank())) {
            result = userRepository.save(user);
        }
        return result;
    }

    /**
     * Login user.
     *
     * @param username the username
     * @param password the password
     * @return the user
     */
    public User login(final String username, final String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
