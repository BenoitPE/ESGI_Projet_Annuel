package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.entities.UserMedia;
import com.projetannuel.userapi.services.UserMediaService;
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
public class UserMediaController {
    @Autowired
    private UserMediaService usermediaService;

    @Operation(summary = "Séléction de la collection d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getCollection", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
    public ResponseEntity<List<Content>> getUserCollectionByIdUser(@RequestParam("Id") Integer IdUser) {
         List<Content> result = usermediaService.getUserCollectionByIdUser(IdUser);
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
        List<Content> result = usermediaService.getUserWishlistByIdUser(IdUser);
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
        String result = usermediaService.addToUserWishlist(MediaType,MediaId,IdUser);
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
        String result = usermediaService.addToUserCollection(MediaType,MediaId,IdUser);
        ResponseEntity response;
        if (0 == result.length()) {
            response = ResponseEntity.status(HttpStatus.OK).body(null);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
        return response;
    }
}
