package com.projetannuel.bookapi.Service;

import com.projetannuel.bookapi.Model.Book;
import com.projetannuel.bookapi.Wrapper.GBWrapper;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public final class BookService {

    public BookService() {
    }

    public List<Book> buildBookListWithWrapper(ResponseEntity<GBWrapper> entity){
        List<Book> books = new ArrayList<>();
        int i = 0;
        while (i <10){
            books.add(buildBookWithWrapper(entity, i));
            i++;
        }
        return books;
    }

    public Book buildBookWithWrapper(ResponseEntity<GBWrapper> entity, Integer id)
    {
        Book book = new Book();
        book.setTitleContent(entity.getBody().getItems()[id].getVolumeInfo().getTitle());
        book.setImageUrl(entity.getBody().getItems()[id].getVolumeInfo().getImageLinks().get("thumbnail"));
        book.setDate(entity.getBody().getItems()[id].getVolumeInfo().getPublishedDate());
        book.setAuthorName(Arrays.toString(entity.getBody().getItems()[id].getVolumeInfo().getAuthors()));
        book.setEditorName(entity.getBody().getItems()[id].getVolumeInfo().getPublisher());
        book.setOverview(entity.getBody().getItems()[id].getVolumeInfo().getDescription());
        book.setAdulte(entity.getBody().getItems()[id].getVolumeInfo().getMaturityRating());
        book.setPageCount(entity.getBody().getItems()[id].getVolumeInfo().getPageCount());
        return book;
    }

    public Book returnBookFromGoogleApiById(String isbn){
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);

        return buildBookWithWrapper(entity, 0);
    }

    public Book returnBookFromGoogleApiByTitle(String Title){
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=intitle:"+Title, GBWrapper.class);

        return buildBookWithWrapper(entity, 0);
    }

    public List<Book> returnBooksFromGoogleApi(){
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=subject+action+maxResults+20", GBWrapper.class);

        return buildBookListWithWrapper(entity);
    }

}
