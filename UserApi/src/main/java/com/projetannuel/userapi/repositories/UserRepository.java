package com.projetannuel.userapi.repositories;
import com.projetannuel.userapi.entities.User;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, String> {
    void deleteByIdUser(Integer IdUser);
    User findByIdUser(Integer IdUser);

    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n" +
            "JOIN MEDIATYPE\n" +
            "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n" +
            "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.COLLECTION = 1", nativeQuery = true)
    List<String> getUserCollectionByIdUser(@Param( "IdUser" )int IdUser);
    @Query(value = "SELECT CONCAT(MEDIATYPE.SERVERURL,USERMEDIA.IDMEDIA) AS Url FROM USERMEDIA\n" +
            "JOIN MEDIATYPE\n" +
            "\tON  MEDIATYPE.NAME = USERMEDIA.MEDIATYPE\n" +
            "WHERE USERMEDIA.IDUSER = :IdUser AND USERMEDIA.WISHLIST = 1", nativeQuery = true)
    List<String> getUserWishlistByIdUser(@Param( "IdUser" )int IdUser);

}

