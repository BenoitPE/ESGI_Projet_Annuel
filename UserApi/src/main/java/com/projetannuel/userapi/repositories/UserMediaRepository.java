package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.UserMedia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMediaRepository extends JpaRepository<UserMedia, String> {

    UserMedia getUserMediaByIdMediaAndMediaTypeAndIdUserAndCollection(String MediaId, String MediaType, Integer UserId, Boolean Collection);

    UserMedia getUserMediaByIdMediaAndMediaTypeAndIdUserAndWishlist(String MediaId, String MediaType, Integer UserId, Boolean Wishlist);

    String deleteUserMediaByIdUserAndIdMediaAndMediaType(Integer UserId,String MediaId, String MediaType);

    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n" +
            "JOIN MEDIATYPE\n" +
            "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n" +
            "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.COLLECTION = 1", nativeQuery = true)
    List<String> getUserCollectionByIdUser(@Param( "IdUser" )Integer IdUser);
    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n" +
            "JOIN MEDIATYPE\n" +
            "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n" +
            "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.WISHLIST = 1", nativeQuery = true)
    List<String> getUserWishlistByIdUser(@Param( "IdUser" )Integer IdUser);
}

