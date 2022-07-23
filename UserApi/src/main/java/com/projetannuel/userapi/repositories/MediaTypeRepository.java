package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.MediaType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MediaTypeRepository extends JpaRepository<MediaType, String> {

    MediaType getMediaTypeByName(String MediaType);

}

