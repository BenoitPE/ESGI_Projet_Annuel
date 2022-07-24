package com.projetannuel.userapi.services;

import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public User createUser(User user) {
        user.setEmail(user.getEmail().trim());
        user.setPassword(user.getPassword().trim());
        user.setUsername(user.getUsername().trim());

        User result = new User();

        if (userRepository.findByUsername(user.getUsername()) == null &&
                (!user.getUsername().isBlank() && !user.getPassword().isBlank())) {
            result = userRepository.save(user);
        }
        return result;
    }

    public User login(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
