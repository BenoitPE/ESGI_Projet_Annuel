package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.entities.User;
import com.projetannuel.userapi.services.UserService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * The type User controller.
 */
@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/")
public class UserController {

    /**
     * Autowire of user service.
     */
    @Autowired
    private UserService userService;

    /**
     * Create user response entity.
     *
     * @param user the user
     * @return the response entity
     */
    @Operation(summary = "Ajout d'un utilisateur")
    @RequestMapping(path = "addUser", method = RequestMethod.POST)
    public ResponseEntity<User> createUser(@RequestBody final User user) {
        User result = userService.createUser(user);
        ResponseEntity response;
        if (null != result) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
        return response;
    }

    /**
     * Login response entity.
     *
     * @param username the username
     * @param password the password
     * @return the response entity
     */
    @Operation(summary = "Retourne un utilisateur si le login est Ok")
    @RequestMapping(path = "login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<User> login(@RequestParam("username") final String username,
                                      @RequestParam("password") final String password) {
        User result = userService.login(username, password);
        ResponseEntity response;
        if (null != result) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return response;
    }
}
