package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;


    @Operation(summary = "Ajout d'un utilisateur")
    @RequestMapping(method = RequestMethod.POST)
    public User createOrUpdate(@RequestBody User user) {
        return userService.createOrUpdate(user);
    }

    @Operation(summary = "Récupération d'utilisateur")
    @RequestMapping(path = "", method = RequestMethod.GET)
    public User get(@RequestParam("Id") Integer IdUser) {
        return userService.getUserByIdUser(IdUser);
    }

    @Operation(summary = "Récupération de tous les utilisateurs")
    @RequestMapping(path = "/all", method = RequestMethod.GET)
    public List<User> getAllUsers() {
        return userService.getAllUser();
    }

    @Operation(summary = "Suppression d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "", method = RequestMethod.DELETE)
    public void deleteUser(@RequestParam("Id") Integer IdUser) {
        userService.deleteByIdUser(IdUser);
    }

    @Operation(summary = "Séléction de la collection d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/collection", method = RequestMethod.GET)
    public List<Content> getUserCollectionByIdUser(@RequestParam("Id") Integer IdUser) {
        return userService.getUserCollectionByIdUser(IdUser);
    }

    @Operation(summary = "Séléction de la wishlist d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/wishlist", method = RequestMethod.GET)
    public List<Content> getUserWishlistByIdUser(@RequestParam("Id") Integer IdUser) {
        return userService.getUserWishlistByIdUser(IdUser);
    }
}
