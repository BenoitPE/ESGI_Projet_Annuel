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

/**
 * The type User media service.
 */
@Service
@Transactional
public class UserMediaService {
    /**
     * Autowire of user media repository.
     */
    @Autowired
    private UserMediaRepository userMediaRepository;

    /**
     * Autowire of user repository.
     */
    @Autowired
    private UserRepository userRepository;

    /**
     * Autowire of media repository.
     */
    @Autowired
    private MediaRepository mediaRepository;

    /**
     * Autowire of media type repository.
     */
    @Autowired
    private MediaTypeRepository mediaTypeRepository;

    /**
     * Gets user collection by id user.
     *
     * @param idUser the id user
     * @return the user collection by id user
     */
    public List<Content> getUserCollectionByIdUser(final Integer idUser) {
        List<String> urls = userMediaRepository.getUserCollectionByIdUser(idUser);
        return getContent(urls);
    }

    /**
     * Gets user wishlist by id user.
     *
     * @param idUser the id user
     * @return the user wishlist by id user
     */
    public List<Content> getUserWishlistByIdUser(final Integer idUser) {
        List<String> urls = userMediaRepository.getUserWishlistByIdUser(idUser);
        return getContent(urls);
    }

    /**
     * Is media in user collection list.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the list
     */
    public Boolean isMediaInUserCollection(final String mediaType, final String mediaId, final Integer idUser) {
        return userMediaRepository.isMediaInUserCollection(mediaId, mediaType, idUser);
    }

    /**
     * Is media in user wishlist list.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the list
     */
    public Boolean isMediaInUserWishlist(final String mediaType, final String mediaId, final Integer idUser) {
        return userMediaRepository.isMediaInUserWishlist(mediaId, mediaType, idUser);
    }


    /**
     * Count media in user collection integer.
     *
     * @param idUser the id user
     * @return the integer
     */
    public Integer countMediaInUserCollection(final Integer idUser) {
        return userMediaRepository.countMediaInUserCollection(idUser);
    }


    /**
     * Count media in user wishlist integer.
     *
     * @param idUser the id user
     * @return the integer
     */
    public Integer countMediaInUserWishlist(final Integer idUser) {
        return userMediaRepository.countMediaInUserWishlist(idUser);
    }

    /**
     * Add to user wishlist string.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the string
     */
    public String addToUserWishlist(final String mediaType, final String mediaId, final Integer idUser) {
        String result = "";
        if (mediaTypeRepository.getMediaTypeByName(mediaType) != null) {
            if (mediaRepository.findMediaByIdMediaAndMediaType(mediaId, mediaType) == null) {
                mediaRepository.save(new Media(mediaId, mediaType));
            }
            if (userRepository.findByIdUser(idUser) != null) {
                if (userMediaRepository.getUserMediaByIdMediaAndMediaTypeAndIdUserAndWishlist(mediaId, mediaType,
                        idUser, true) != null) {
                    userMediaRepository.deleteUserMediaByIdUserAndIdMediaAndMediaType(idUser, mediaId, mediaType);
                } else {
                    userMediaRepository.save(new UserMedia(idUser, mediaId, mediaType, false, true));
                }
            } else {
                result = "L'utilisateur n'existe pas";
            }
        } else {
            result = "Le type de media n'existe pas";
        }
        return result;
    }

    /**
     * Add to user collection string.
     *
     * @param mediaType the media type
     * @param mediaId   the media id
     * @param idUser    the id user
     * @return the string
     */
    public String addToUserCollection(final String mediaType, final String mediaId, final Integer idUser) {
        String result = "";
        if (mediaTypeRepository.getMediaTypeByName(mediaType) != null) {
            if (mediaRepository.findMediaByIdMediaAndMediaType(mediaId, mediaType) == null) {
                mediaRepository.save(new Media(mediaId, mediaType));
            }
            if (userRepository.findByIdUser(idUser) != null) {
                if (userMediaRepository.getUserMediaByIdMediaAndMediaTypeAndIdUserAndCollection(mediaId, mediaType,
                        idUser, true) != null) {
                    userMediaRepository.deleteUserMediaByIdUserAndIdMediaAndMediaType(idUser, mediaId, mediaType);
                } else {
                    userMediaRepository.save(new UserMedia(idUser, mediaId, mediaType, true, false));
                }
            } else {
                result = "L'utilisateur n'existe pas";
            }
        } else {
            result = "Le type de media n'existe pas";
        }
        return result;
    }

    /**
     * Gets content.
     *
     * @param urls the urls
     * @return the content
     */
    public List<Content> getContent(final List<String> urls) {
        RestTemplate restTemplate = new RestTemplate();
        List<Content> contents = new ArrayList<Content>();
        urls.forEach(url -> {
            try {
                ResponseEntity<String> entity = restTemplate.getForEntity(url, String.class);
                if (null != entity.getBody()) {
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
