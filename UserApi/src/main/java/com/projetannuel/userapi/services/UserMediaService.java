package com.projetannuel.userapi.services;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.Media;
import com.projetannuel.userapi.entities.UserMedia;
import com.projetannuel.userapi.repositories.MediaRepository;
import com.projetannuel.userapi.repositories.MediaTypeRepository;
import com.projetannuel.userapi.repositories.UserMediaRepository;
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
public class UserMediaService {
   @Autowired
   private UserMediaRepository userMediaRepository;

   @Autowired
   private UserRepository userRepository;

   @Autowired
   private MediaRepository mediaRepository;

   @Autowired
   private MediaTypeRepository mediaTypeRepository;

   public List<Content> getUserCollectionByIdUser(Integer IdUser) {
      List<String> Urls = userMediaRepository.getUserCollectionByIdUser(IdUser);
      return getContent(Urls);
   }

   public List<Content> getUserWishlistByIdUser(Integer IdUser) {
      List<String> Urls = userMediaRepository.getUserWishlistByIdUser(IdUser);
      return getContent(Urls);
   }

   public String addToUserWishlist(String MediaType, String MediaId, Integer IdUser) {
      String result = "";
      if (mediaTypeRepository.getMediaTypeByName(MediaType) != null) {
         if (mediaRepository.findMediaByIdMediaAndMediaType(MediaId, MediaType) == null) {
            mediaRepository.save(new Media(MediaId, MediaType));
         }
         if (userRepository.findByIdUser(IdUser) != null) {
            if (userMediaRepository.getUserMediaByIdMediaAndMediaTypeAndIdUserAndWishlist(MediaId, MediaType, IdUser, true) != null) {
               userMediaRepository.deleteUserMediaByIdUserAndIdMediaAndMediaType(IdUser,MediaId,MediaType);
            } else {
               userMediaRepository.save(new UserMedia(IdUser, MediaId, MediaType, false, true));
            }
         } else {
            result = "L'utilisateur n'existe pas";
         }
      } else {
         result = "Le type de media n'existe pas";
      }
      return result;
   }

   public String addToUserCollection(String MediaType, String MediaId, Integer IdUser) {
      String result = "";
      if (mediaTypeRepository.getMediaTypeByName(MediaType) != null) {
         if (mediaRepository.findMediaByIdMediaAndMediaType(MediaId, MediaType) == null) {
            mediaRepository.save(new Media(MediaId, MediaType));
         }
         if (userRepository.findByIdUser(IdUser) != null) {
            if (userMediaRepository.getUserMediaByIdMediaAndMediaTypeAndIdUserAndCollection(MediaId, MediaType, IdUser, true) != null) {
               userMediaRepository.deleteUserMediaByIdUserAndIdMediaAndMediaType(IdUser,MediaId,MediaType);
            } else {
               userMediaRepository.save(new UserMedia(IdUser, MediaId, MediaType, true, false));
            }
         } else {
            result = "L'utilisateur n'existe pas";
         }
      } else {
         result = "Le type de media n'existe pas";
      }
      return result;
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

}
