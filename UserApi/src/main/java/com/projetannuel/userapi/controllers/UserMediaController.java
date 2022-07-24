package com.projetannuel.userapi.controllers;

import com.projetannuel.userapi.Models.Content;
import com.projetannuel.userapi.services.UserMediaService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * The type User media controller.
 */
@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/")
public class UserMediaController {
    /**
     * Autowire of user media service.
     */
    @Autowired
    private UserMediaService usermediaService;

    /**
     * Gets user collection by id user.
     *
     * @param idUser the id user
     * @return the user collection by id user
     */
    @Operation(summary = "Séléction de la collection d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getCollection", method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<Content>> getUserCollectionByIdUser(@RequestParam("Id") final Integer idUser) {
        List<Content> result = usermediaService.getUserCollectionByIdUser(idUser);
        ResponseEntity response;
        if (0 != result.size()) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        }
        return response;
    }

    /**
     * Gets user wishlist by id user.
     *
     * @param idUser the id user
     * @return the user wishlist by id user
     */
    @Operation(summary = "Séléction de la wishlist d'un utilisateur à partir de son identifiant")
    @RequestMapping(path = "/getWishlist", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<Content>> getUserWishlistByIdUser(@RequestParam("idUser") final Integer idUser) {
        List<Content> result = usermediaService.getUserWishlistByIdUser(idUser);
        ResponseEntity response;
        if (0 != result.size()) {
            response = ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        }
        return response;
    }

    /**
     * Add to user wishlist response entity.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the response entity
     */
    @Operation(summary = "Ajout d'un media dans la wishlist d'un utilisateur")
    @RequestMapping(path = "/addToWishlist", method = RequestMethod.POST)
    public ResponseEntity<String> addToUserWishlist(@RequestParam("mediaType") final String mediaType,
                                                    @RequestParam("mediaId") final String mediaId,
                                                    @RequestParam("idUser") final Integer idUser) {
        String result = usermediaService.addToUserWishlist(mediaType, mediaId, idUser);
        ResponseEntity response;
        if (0 == result.length()) {
            response = ResponseEntity.status(HttpStatus.OK).body(null);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
        return response;
    }

    /**
     * Add to user collection response entity.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the response entity
     */
    @Operation(summary = "Ajout d'un media dans la collection d'un utilisateur")
    @RequestMapping(path = "/addToCollection", method = RequestMethod.POST)
    public ResponseEntity<String> addToUserCollection(@RequestParam("mediaType") final String mediaType,
                                                      @RequestParam("mediaId") final String mediaId,
                                                      @RequestParam("idUser") final Integer idUser) {
        String result = usermediaService.addToUserCollection(mediaType, mediaId, idUser);
        ResponseEntity response;
        if (0 == result.length()) {
            response = ResponseEntity.status(HttpStatus.OK).body(null);
        } else {
            response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
        return response;
    }
}
