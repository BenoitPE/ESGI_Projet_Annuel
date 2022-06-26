package com.projetannuel.bookapi.Service;

import com.projetannuel.bookapi.Model.Book;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public final class BookService {

    public BookService() {
    }

    public List<Book> getBooks(){
        List<Book> books = new ArrayList<>();
        // foreach on a list from google apiBook
       // books.add(this.getBook());
       // books.add(this.getBook());
        return books;
    }

    public Book buildBookWithWrapper(ResponseEntity<GBWrapper> entity)
    {
        Book book = new Book();
        book.setId(1);
        book.setTitleContent(entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        book.setImageUrl(entity.getBody().getItems()[0].getVolumeInfo().getImageLinks().get("infoLink"));
        book.setDate(entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        book.setAuthorName(Arrays.toString(entity.getBody().getItems()[0].getVolumeInfo().getAuthors()));
        book.setEditorName(entity.getBody().getItems()[0].getVolumeInfo().getPublisher());
        return book;
    }

    public Object getGoogleDetail(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);
    }

    public Book returnBookFromGoogleApi(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);

        return buildBookWithWrapper(entity);
    }


}
