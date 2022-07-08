package com.projetannuel.userapi.services;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
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

    public void deleteByIdUser(Integer IdUser) {
        userRepository.deleteByIdUser(IdUser);
    }

    public List<Content> getUserCollectionByIdUser(Integer IdUser) {

        List<String> Urls = userRepository.getUserCollectionByIdUser(IdUser);
        return getContent(Urls);
    }

    public List<Content> getUserWishlistByIdUser(Integer IdUser) {

        List<String> Urls = userRepository.getUserWishlistByIdUser(IdUser);
        return getContent(Urls);
    }

    public List<Content> getContent(List<String> Urls)
    {
        RestTemplate restTemplate = new RestTemplate();
        List<Content> contents = new ArrayList<Content>();
        Urls.forEach(url -> {
            ResponseEntity<String> entity = restTemplate.getForEntity(url, String.class);
            contents.add(new Content(entity.getBody()));
        });
        return contents;
    }
}
