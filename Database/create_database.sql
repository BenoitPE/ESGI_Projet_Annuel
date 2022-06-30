/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  30/06/2022 12:49:50                      */
/*==============================================================*/


drop table if exists ANIME;

drop table if exists AUTHOR;

drop table if exists BOOK;

drop table if exists CHARACTER;

drop table if exists CHARACTERANIME;

drop table if exists CHARACTERMOVIE;

drop table if exists CHARACTERSERIE;

drop table if exists COLLECTION;

drop table if exists GENRE;

drop table if exists GENRES;

drop table if exists MEDIA;

drop table if exists MOVIE;

drop table if exists SERIE;

drop table if exists USER;

drop table if exists WISHLIST;

drop table if exists "WRITE";

/*==============================================================*/
/* Table : ANIME                                                */
/*==============================================================*/
create table ANIME
(
   IDCONTENT            int not null,
   IDANIME              int not null,
   TITLECONTENT         longtext,
   IMAGEURL             longtext,
   DATE                 date,
   ADULT                bool,
   OVERVIEW             longtext,
   EPISODES             int,
   DURATION             int,
   primary key (IDCONTENT, IDANIME)
);

/*==============================================================*/
/* Table : AUTHOR                                               */
/*==============================================================*/
create table AUTHOR
(
   IDAUTHOR             int not null,
   NAME                 longtext,
   primary key (IDAUTHOR)
);

/*==============================================================*/
/* Table : BOOK                                                 */
/*==============================================================*/
create table BOOK
(
   IDCONTENT            int not null,
   IDBOOK               int not null,
   TITLECONTENT         longtext,
   IMAGEURL             longtext,
   DATE                 date,
   ADULT                bool,
   OVERVIEW             longtext,
   EDITORNAME           longtext,
   PAGENUMBER           int,
   primary key (IDCONTENT, IDBOOK)
);

/*==============================================================*/
/* Table : CHARACTER                                            */
/*==============================================================*/
create table CHARACTER
(
   IDCREDITSMEMBER      int not null,
   NAME                 longtext,
   ROLE                 longtext,
   IMAGEURLCREDITSMEMBER longtext,
   primary key (IDCREDITSMEMBER)
);

/*==============================================================*/
/* Table : CHARACTERANIME                                       */
/*==============================================================*/
create table CHARACTERANIME
(
   IDCONTENT            int not null,
   IDANIME              int not null,
   IDCREDITSMEMBER      int not null,
   primary key (IDCONTENT, IDANIME, IDCREDITSMEMBER)
);

/*==============================================================*/
/* Table : CHARACTERMOVIE                                       */
/*==============================================================*/
create table CHARACTERMOVIE
(
   IDCONTENT            int not null,
   MOV_IDMOVIE          int not null,
   IDCREDITSMEMBER      int not null,
   MOV_IDCONTENT        int not null,
   IDMOVIE              int not null,
   primary key (IDCONTENT, MOV_IDMOVIE, IDCREDITSMEMBER, MOV_IDCONTENT, IDMOVIE)
);

/*==============================================================*/
/* Table : CHARACTERSERIE                                       */
/*==============================================================*/
create table CHARACTERSERIE
(
   IDCONTENT            int not null,
   IDSERIE              int not null,
   IDCREDITSMEMBER      int not null,
   primary key (IDCONTENT, IDSERIE, IDCREDITSMEMBER)
);

/*==============================================================*/
/* Table : COLLECTION                                           */
/*==============================================================*/
create table COLLECTION
(
   IDCONTENT            int not null,
   IDUSER               int not null,
   primary key (IDCONTENT, IDUSER)
);

/*==============================================================*/
/* Table : GENRE                                                */
/*==============================================================*/
create table GENRE
(
   IDGENRE              int not null,
   NAMEGENRE            longtext,
   primary key (IDGENRE)
);

/*==============================================================*/
/* Table : GENRES                                               */
/*==============================================================*/
create table GENRES
(
   IDGENRE              int not null,
   IDCONTENT            int not null,
   primary key (IDGENRE, IDCONTENT)
);

/*==============================================================*/
/* Table : MEDIA                                                */
/*==============================================================*/
create table MEDIA
(
   IDCONTENT            int not null,
   TITLECONTENT         longtext,
   IMAGEURL             longtext,
   DATE                 date,
   ADULT                bool,
   OVERVIEW             longtext,
   primary key (IDCONTENT)
);

/*==============================================================*/
/* Table : MOVIE                                                */
/*==============================================================*/
create table MOVIE
(
   IDCONTENT            int not null,
   IDMOVIE              int not null,
   TITLECONTENT         longtext,
   IMAGEURL             longtext,
   DATE                 date,
   ADULT                bool,
   OVERVIEW             longtext,
   TRAILERURL           longtext,
   primary key (IDCONTENT, IDMOVIE)
);

/*==============================================================*/
/* Table : SERIE                                                */
/*==============================================================*/
create table SERIE
(
   IDCONTENT            int not null,
   IDSERIE              int not null,
   TITLECONTENT         longtext,
   IMAGEURL             longtext,
   DATE                 date,
   ADULT                bool,
   OVERVIEW             longtext,
   primary key (IDCONTENT, IDSERIE)
);

/*==============================================================*/
/* Table : USER                                                 */
/*==============================================================*/
create table USER
(
   IDUSER               int not null,
   USERNAME             varchar(30) not null,
   EMAIL                varchar(320) not null,
   PASSWORD             varchar(128) not null,
   primary key (IDUSER)
);

/*==============================================================*/
/* Table : WISHLIST                                             */
/*==============================================================*/
create table WISHLIST
(
   IDUSER               int not null,
   IDCONTENT            int not null,
   primary key (IDUSER, IDCONTENT)
);

/*==============================================================*/
/* Table : "WRITE"                                              */
/*==============================================================*/
create table "WRITE"
(
   IDCONTENT            int not null,
   IDBOOK               int not null,
   IDAUTHOR             int not null,
   primary key (IDCONTENT, IDBOOK, IDAUTHOR)
);

alter table ANIME add constraint FK_MEDIALEGACY4 foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table BOOK add constraint FK_MEDIALEGACY3 foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table CHARACTERANIME add constraint FK_CHARACTERANIME foreign key (IDCONTENT, IDANIME)
      references ANIME (IDCONTENT, IDANIME) on delete restrict on update restrict;

alter table CHARACTERANIME add constraint FK_CHARACTERANIME2 foreign key (IDCREDITSMEMBER)
      references CHARACTER (IDCREDITSMEMBER) on delete restrict on update restrict;

alter table CHARACTERMOVIE add constraint FK_CHARACTERMOVIE foreign key (IDCONTENT, MOV_IDMOVIE)
      references MOVIE (IDCONTENT, IDMOVIE) on delete restrict on update restrict;

alter table CHARACTERMOVIE add constraint FK_CHARACTERMOVIE2 foreign key (IDCREDITSMEMBER)
      references CHARACTER (IDCREDITSMEMBER) on delete restrict on update restrict;

alter table CHARACTERMOVIE add constraint FK_CHARACTERMOVIE3 foreign key (MOV_IDCONTENT, IDMOVIE)
      references MOVIE (IDCONTENT, IDMOVIE) on delete restrict on update restrict;

alter table CHARACTERSERIE add constraint FK_CHARACTERSERIE foreign key (IDCONTENT, IDSERIE)
      references SERIE (IDCONTENT, IDSERIE) on delete restrict on update restrict;

alter table CHARACTERSERIE add constraint FK_CHARACTERSERIE2 foreign key (IDCREDITSMEMBER)
      references CHARACTER (IDCREDITSMEMBER) on delete restrict on update restrict;

alter table COLLECTION add constraint FK_COLLECTION foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table COLLECTION add constraint FK_COLLECTION2 foreign key (IDUSER)
      references USER (IDUSER) on delete restrict on update restrict;

alter table GENRES add constraint FK_GENRES foreign key (IDGENRE)
      references GENRE (IDGENRE) on delete restrict on update restrict;

alter table GENRES add constraint FK_GENRES2 foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table MOVIE add constraint FK_MEDIALEGACY foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table SERIE add constraint FK_MEDIALEGACY2 foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table WISHLIST add constraint FK_WISHLIST foreign key (IDUSER)
      references USER (IDUSER) on delete restrict on update restrict;

alter table WISHLIST add constraint FK_WISHLIST2 foreign key (IDCONTENT)
      references MEDIA (IDCONTENT) on delete restrict on update restrict;

alter table "WRITE" add constraint FK_WRITE foreign key (IDCONTENT, IDBOOK)
      references BOOK (IDCONTENT, IDBOOK) on delete restrict on update restrict;

alter table "WRITE" add constraint FK_WRITE2 foreign key (IDAUTHOR)
      references AUTHOR (IDAUTHOR) on delete restrict on update restrict;

