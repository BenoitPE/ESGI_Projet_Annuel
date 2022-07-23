package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.Media;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface MediaRepository extends JpaRepository<Media, String> {

    Media findMediaByIdMediaAndMediaType(String MediaId, String MediaType);

}

