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

   public User createOrUpdate(User user) {
      return userRepository.save(user);
   }

   public User login(String username, String password) {
      return userRepository.findByUsernameAndPassword(username, password);
   }
}
