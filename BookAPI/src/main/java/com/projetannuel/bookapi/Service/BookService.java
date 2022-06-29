package com.projetannuel.bookapi.Service;

import com.projetannuel.bookapi.Model.Book;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public final class BookService {

    public BookService() {
    }

    public List<Book> buidBookListWithWrapper(){
        List<Book> books = new ArrayList<>();
        // foreach on a list from google apiBook
       // books.add(this.getBook());
       // books.add(this.getBook());
        return books;
    }

    public Book buildBookWithWrapper(ResponseEntity<GBWrapper> entity)
    {
        Book book = new Book();
        book.setId("identifier");
        book.setTitleContent(entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        book.setImageUrl(entity.getBody().getItems()[0].getVolumeInfo().getImageLinks().get("thumbnail"));
        book.setDate(entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        book.setAuthorName(Arrays.toString(entity.getBody().getItems()[0].getVolumeInfo().getAuthors()));
        book.setEditorName(entity.getBody().getItems()[0].getVolumeInfo().getPublisher());
        return book;
    }

    public Book returnBookFromGoogleApi(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);

        return buildBookWithWrapper(entity);
    }

    public Book returnBookFromGoogleApiByTitle(String Title){
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=intitle:"+Title, GBWrapper.class);

        return buildBookWithWrapper(entity);
    }

    public Book returnBookFromGoogleApiByAuthor(String Author){
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=inauthor:"+Author, GBWrapper.class);

        return buildBookWithWrapper(entity);
    }

}
