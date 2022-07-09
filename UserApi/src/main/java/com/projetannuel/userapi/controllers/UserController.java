package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class UserController {
    @Autowired
    private UserService userService;

    @Operation(summary = "Ajout d'un utilisateur")
    @RequestMapping(path = "addUser", method = RequestMethod.POST)
    public User createOrUpdate(@RequestBody User user) {
        return userService.createOrUpdate(user);
    }

    @Operation(summary = "Récupération d'un utilisateur")
    @RequestMapping(path = "getUser", method = RequestMethod.GET)
    public User get(@RequestParam("Id") Integer IdUser) {
        return userService.getUserByIdUser(IdUser);
    }

    @Operation(summary = "Récupération de tous les utilisateurs")
    @RequestMapping(path = "/getAllUsers", method = RequestMethod.GET)
    public List<User> getAllUsers() {
        return userService.getAllUser();
    }

     @Operation(summary = "Séléction de la collection d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getCollection", method = RequestMethod.GET)
    public List<Content> getUserCollectionByIdUser(@RequestParam("Id") Integer IdUser) {
        return userService.getUserCollectionByIdUser(IdUser);
    }
    @Operation(summary = "Séléction de la wishlist d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getWishlist", method = RequestMethod.GET)
    public List<Content> getUserWishlistByIdUser(@RequestParam("Id") Integer IdUser) {
        return userService.getUserWishlistByIdUser(IdUser);
    }

    @Operation(summary = "Ajout d'un media dans la wishlist d'un utilisateur")
    @RequestMapping(path = "/addToWishlist", method = RequestMethod.POST)
    public String addToUserWishlist(@RequestParam("MediaType") String MediaType,@RequestParam("MediaId") String MediaId,@RequestParam("Id") Integer IdUser) {
        return userService.addToUserWishlist(MediaType,MediaId,IdUser);
    }

    @Operation(summary = "Ajout d'un media dans la collection d'un utilisateur")
    @RequestMapping(path = "/addToCollection", method = RequestMethod.POST)
    public String addToUserCollection(@RequestParam("MediaType") String MediaType,@RequestParam("MediaId") String MediaId,@RequestParam("Id") Integer IdUser) {
        return userService.addToUserCollection(MediaType,MediaId,IdUser);
    }
}
