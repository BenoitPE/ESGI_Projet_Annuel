package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/")
public class UserController {
    @Autowired
    private UserService userService;

    @Operation(summary = "Ajout d'un utilisateur")
    @RequestMapping(path = "addUser", method = RequestMethod.POST)
    public ResponseEntity<User> createUser(@RequestBody User user) {
        User result = userService.createUser(user);
        ResponseEntity response;
        if (null != result.getIdUser()) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
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
}
