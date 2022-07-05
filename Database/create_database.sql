/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  05/07/2022 10:39:13                      */
/*==============================================================*/


drop table if exists MEDIA;

drop table if exists MEDIATYPE;

drop table if exists USER;

drop table if exists USERMEDIA;

/*==============================================================*/
/* Table : MEDIA                                                */
/*==============================================================*/
create table MEDIA
(
   IDMEDIA              varchar(100) not null,
   MEDIATYPE            varchar(50) not null,
   SERVERURL            varchar(2048) not null,
   primary key (IDMEDIA, MEDIATYPE)
);

/*==============================================================*/
/* Table : MEDIATYPE                                            */
/*==============================================================*/
create table MEDIATYPE
(
   NAME                 varchar(50) not null,
   primary key (NAME)
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
/* Table : USERMEDIA                                            */
/*==============================================================*/
create table USERMEDIA
(
   IDUSER               int not null,
   IDMEDIA              varchar(100) not null,
   MEDIATYPE            varchar(50) not null,
   primary key (IDUSER, IDMEDIA, MEDIATYPE)
);

alter table MEDIA add constraint FK_HAS_TYPE foreign key (MEDIATYPE)
      references MEDIATYPE (NAME) on delete restrict on update restrict;

alter table USERMEDIA add constraint FK_USERMEDIA foreign key (IDUSER)
      references USER (IDUSER) on delete restrict on update restrict;

alter table USERMEDIA add constraint FK_USERMEDIA2 foreign key (IDMEDIA, MEDIATYPE)
      references MEDIA (IDMEDIA, MEDIATYPE) on delete restrict on update restrict;

