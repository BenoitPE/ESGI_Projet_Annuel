DELIMITER ;;
CREATE PROCEDURE `StoredUpdateUserWishlist` (IN `MediaType` varchar(50), IN `MediaId` varchar(100), IN `UserId` int, OUT `Error` varchar(50))
BEGIN
IF (SELECT IF (
      EXISTS(
         SELECT * FROM MEDIATYPE WHERE NAME = MediaType),1,0)) = 1
   AND (SELECT IF (
      EXISTS(
         SELECT * FROM MEDIA WHERE IDMEDIA = MediaId AND MEDIATYPE = MediaType),1,0)) = 0
 THEN
   INSERT INTO MEDIA (IDMEDIA,MEDIATYPE) VALUES(MediaId ,MediaType);
 END IF;

 IF (SELECT IF (
      EXISTS(
         SELECT * FROM MEDIATYPE WHERE NAME = MediaType),1,0)) = 1
 THEN
   IF (SELECT IF (
         EXISTS(
            SELECT * FROM USERMEDIA WHERE IDMEDIA = MediaId AND MEDIATYPE = MediaType AND WISHLIST = 0),1,0)) = 1
   THEN
      UPDATE USERMEDIA SET WISHLIST = 1 , COLLECTION = 0 WHERE IDUSER = UserId AND IDMEDIA = MediaId AND MEDIATYPE = MediaType;
   ELSEIF (SELECT IF (
         EXISTS(
            SELECT * FROM USERMEDIA WHERE IDMEDIA = MediaId AND MEDIATYPE = MediaType AND WISHLIST = 1),1,0)) = 1
   THEN
      UPDATE USERMEDIA SET WISHLIST = 0 , COLLECTION = 0 WHERE IDUSER = UserId AND IDMEDIA = MediaId AND MEDIATYPE = MediaType;
   ELSEIF (SELECT IF (
         EXISTS(
            SELECT * FROM USER WHERE IDUSER = UserId),1,0)) = 1
   THEN
      INSERT INTO USERMEDIA (IDUSER,IDMEDIA,MEDIATYPE,WISHLIST,COLLECTION) VALUES(UserId,MediaId,MediaType,1,0);
   ELSE
      SET Error = 'L''utilisateur n''existe pas';
      END IF;
   ELSE
   SET Error = 'Le type de media n''existe pas';
   END IF;
END;;
DELIMITER ;