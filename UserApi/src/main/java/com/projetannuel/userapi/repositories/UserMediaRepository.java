package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.UserMedia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The interface User media repository.
 */
@Repository
public interface UserMediaRepository extends JpaRepository<UserMedia, String> {

    /**
     * Gets user media by id media and media type and id user and collection.
     *
     * @param mediaId    the media id
     * @param mediaType  the media type
     * @param userId     the user id
     * @param collection the collection
     * @return the user media by id media and media type and id user and collection
     */
    UserMedia getUserMediaByIdMediaAndMediaTypeAndIdUserAndCollection(String mediaId, String mediaType, Integer userId,
                                                                      Boolean collection);

    /**
     * Gets user media by id media and media type and id user and wishlist.
     *
     * @param mediaId   the media id
     * @param mediaType the media type
     * @param userId    the user id
     * @param wishlist  the wishlist
     * @return the user media by id media and media type and id user and wishlist
     */
    UserMedia getUserMediaByIdMediaAndMediaTypeAndIdUserAndWishlist(String mediaId, String mediaType, Integer userId,
                                                                    Boolean wishlist);

    /**
     * Is media in user collection boolean.
     *
     * @param mediaId   the media id
     * @param mediaType the media type
     * @param userId    the user id
     * @return the boolean
     */
    @Query(value = "SELECT USERMEDIA.COLLECTION\n"
            + "FROM USERMEDIA WHERE USERMEDIA.IDUSER = :userId \n"
            + "AND USERMEDIA.IDMEDIA = :mediaId\n"
            + "AND USERMEDIA.MEDIATYPE = :mediaType", nativeQuery = true)
    Boolean isMediaInUserCollection(String mediaId, String mediaType, Integer userId);


    /**
     * Is media in user wishlist boolean.
     *
     * @param mediaId   the media id
     * @param mediaType the media type
     * @param userId    the user id
     * @return the boolean
     */
    @Query(value = "SELECT USERMEDIA.WISHLIST\n"
            + "FROM USERMEDIA WHERE USERMEDIA.IDUSER = :userId \n"
            + "AND USERMEDIA.IDMEDIA = :mediaId\n"
            + "AND USERMEDIA.MEDIATYPE = :mediaType", nativeQuery = true)
    Boolean isMediaInUserWishlist(String mediaId, String mediaType, Integer userId);


    /**
     * Count media in user collection integer.
     *
     * @param userId the user id
     * @return the integer
     */
    @Query(value = "SELECT COUNT(*) FROM USERMEDIA\n"
            + "WHERE USERMEDIA.IDUSER = :userId\n"
            + "AND USERMEDIA.COLLECTION = 1", nativeQuery = true)
    Integer countMediaInUserCollection(Integer userId);


    /**
     * Count media in user wishlist integer.
     *
     * @param userId the user id
     * @return the integer
     */
    @Query(value = "SELECT COUNT(*) FROM USERMEDIA\n"
            + "WHERE USERMEDIA.IDUSER = :userId\n"
            + "AND USERMEDIA.WISHLIST = 1", nativeQuery = true)
    Integer countMediaInUserWishlist(Integer userId);

    /**
     * Delete user media by id user and id media and media type string.
     *
     * @param userId    the user id
     * @param mediaId   the media id
     * @param mediaType the media type
     * @return the string
     */
    String deleteUserMediaByIdUserAndIdMediaAndMediaType(Integer userId, String mediaId, String mediaType);

    /**
     * Gets user collection by id user.
     *
     * @param idUser the id user
     * @return the user collection by id user
     */
    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n"
            + "JOIN MEDIATYPE\n"
            + "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n"
            + "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.COLLECTION = 1", nativeQuery = true)
    List<String> getUserCollectionByIdUser(@Param("IdUser") Integer idUser);

    /**
     * Gets user wishlist by id user.
     *
     * @param idUser the id user
     * @return the user wishlist by id user
     */
    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n"
            + "JOIN MEDIATYPE\n"
            + "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n"
            + "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.WISHLIST = 1", nativeQuery = true)
    List<String> getUserWishlistByIdUser(@Param("IdUser") Integer idUser);
}

