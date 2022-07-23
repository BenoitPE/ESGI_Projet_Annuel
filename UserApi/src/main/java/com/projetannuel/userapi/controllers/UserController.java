package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/")
public class UserController {
    @Autowired
    private UserService userService;

    @Operation(summary = "Ajout d'un utilisateur")
    @RequestMapping(path = "addUser", method = RequestMethod.POST)
    public ResponseEntity<User> createOrUpdate(@RequestBody User user) {
        User result = userService.createOrUpdate(user);
        ResponseEntity response;
        if (null != result) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
        return response;
    }

    @Operation(summary = "Récupération d'un utilisateur")
    @RequestMapping(path = "getUser", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<User> get(@RequestParam("Id") Integer IdUser) {
        User result = userService.getUserByIdUser(IdUser);
        ResponseEntity response;
        if (null != result) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return response;
    }

    @Operation(summary = "Retourne un utilisateur si le login est Ok")
    @RequestMapping(path = "login", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<User> login(@RequestParam("Username") String Username,@RequestParam("Password") String Password) {
        User result = userService.login(Username,Password);
        ResponseEntity response;
        if (null != result) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return response;
    }

    @Operation(summary = "Récupération de tous les utilisateurs")
    @RequestMapping(path = "/getAllUsers", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> result = userService.getAllUser();
        ResponseEntity response;
        if (0 != result.size()) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        }
        return response;
    }

     @Operation(summary = "Séléction de la collection d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getCollection", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
    public ResponseEntity<List<Content>> getUserCollectionByIdUser(@RequestParam("Id") Integer IdUser) {
         List<Content> result = userService.getUserCollectionByIdUser(IdUser);
         ResponseEntity response;
         if (0 != result.size()) {
             response = ResponseEntity.status(HttpStatus.OK).body(result);
         } else {
             response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
         }
         return response;
    }
    @Operation(summary = "Séléction de la wishlist d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getWishlist", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<Content>> getUserWishlistByIdUser(@RequestParam("Id") Integer IdUser) {
        List<Content> result = userService.getUserWishlistByIdUser(IdUser);
        ResponseEntity response;
        if (0 != result.size()) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        }
        return response;
    }

    @Operation(summary = "Ajout d'un media dans la wishlist d'un utilisateur")
    @RequestMapping(path = "/addToWishlist", method = RequestMethod.POST)
    public ResponseEntity<String> addToUserWishlist(@RequestParam("MediaType") String MediaType,@RequestParam("MediaId") String MediaId,@RequestParam("Id") Integer IdUser) {
        String result = userService.addToUserWishlist(MediaType,MediaId,IdUser);
        ResponseEntity response;
        if (0 == result.length()){
            response = ResponseEntity.status(HttpStatus.OK).body(null);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
        return response;
    }

    @Operation(summary = "Ajout d'un media dans la collection d'un utilisateur")
    @RequestMapping(path = "/addToCollection", method = RequestMethod.POST)
    public ResponseEntity<String> addToUserCollection(@RequestParam("MediaType") String MediaType, @RequestParam("MediaId") String MediaId, @RequestParam("Id") Integer IdUser) {
        String result = userService.addToUserCollection(MediaType,MediaId,IdUser);
        ResponseEntity response;
        if (0 == result.length()) {
            response = ResponseEntity.status(HttpStatus.OK).body(null);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
        return response;
    }
}
