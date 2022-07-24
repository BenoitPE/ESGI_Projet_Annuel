package com.projetannuel.userapi.repositories;

import com.projetannuel.userapi.entities.Media;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface Media repository.
 */
@Repository
public interface MediaRepository extends JpaRepository<Media, String> {

    /**
     * Find media by id media and media type media.
     *
     * @param mediaId   the media id
     * @param mediaType the media type
     * @return the media
     */
    Media findMediaByIdMediaAndMediaType(String mediaId, String mediaType);

}

