package com.projetannuel.userapi.repositories;
import com.projetannuel.userapi.entities.User;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, String> {
    User findByIdUser(Integer IdUser);

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
    @Query(value = "CALL StoredUpdateUserWishlist(:MediaType,:MediaId,:IdUser)", nativeQuery = true)
    String StoredUpdateUserWishlist(@Param( "MediaType" )String MediaType, @Param( "MediaId" )String MediaId, @Param( "IdUser" )Integer IdUser);

    @Query(value = "CALL StoredUpdateUserCollection(:MediaType,:MediaId,:IdUser)", nativeQuery = true)
    String StoredUpdateUserCollection(@Param( "MediaType" )String MediaType, @Param( "MediaId" )String MediaId, @Param( "IdUser" )Integer IdUser);

}

