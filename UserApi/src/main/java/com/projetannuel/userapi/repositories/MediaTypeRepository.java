package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.MediaType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface Media type repository.
 */
@Repository
public interface MediaTypeRepository extends JpaRepository<MediaType, String> {

    /**
     * Gets media type by name.
     *
     * @param mediaType the media type
     * @return the media type by name
     */
    MediaType getMediaTypeByName(String mediaType);

}

