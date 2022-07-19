package com.projetannuel.userapi.services;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class UserService {
   @Autowired
   private UserRepository userRepository;

   public User createOrUpdate(User user) {
      return userRepository.save(user);
   }

   public User getUserByIdUser(Integer Id) {
      return userRepository.findByIdUser(Id);
   }

   public List<User> getAllUser() {
      return userRepository.findAll();
   }

   public List<Content> getUserCollectionByIdUser(Integer IdUser) {

      List<String> Urls = userRepository.getUserCollectionByIdUser(IdUser);
      return getContent(Urls);
   }

   public List<Content> getUserWishlistByIdUser(Integer IdUser) {

      List<String> Urls = userRepository.getUserWishlistByIdUser(IdUser);
      return getContent(Urls);
   }

   public String addToUserWishlist(String MediaType, String MediaId, Integer IdUser) {
      return userRepository.StoredUpdateUserWishlist(MediaType, MediaId, IdUser);
   }

   public String addToUserCollection(String MediaType, String MediaId, Integer IdUser) {
      return userRepository.StoredUpdateUserCollection(MediaType, MediaId, IdUser);
   }

   public List<Content> getContent(List<String> Urls) {
      RestTemplate restTemplate = new RestTemplate();
      List<Content> contents = new ArrayList<Content>();
      Urls.forEach(url -> {
         try {
            ResponseEntity<String> entity = restTemplate.getForEntity(url, String.class);
            if(null != entity.getBody()) {
               Content content = new Content(entity.getBody());
               if (content.getId() != null) {
                  contents.add(content);
               }
            }
         } catch (RestClientException ignored) {

         }
      });
      return contents;
   }

   public User login(String username, String password) {
      return userRepository.findByUsernameAndPassword(username, password);
   }
}
