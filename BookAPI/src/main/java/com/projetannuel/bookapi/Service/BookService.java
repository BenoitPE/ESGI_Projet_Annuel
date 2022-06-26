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

    //traitement des livres reçus ?

    // convertir un livre book google api  en notre bookapi

    //faire une conversion sur une liste

    public String string(){
        return "test";
    }

    public Book getBook()
    {
        Book book = new Book();
        book.setId(1);
        book.setTitleContent("test");
        book.setImageUrl("test");
        book.setDate(String.valueOf(new Date(1 / 1999)));
        book.setAuthorName("question");
        book.setEditorName("sondage");
        return book;
    }

    public List<Book> getBooks(){
        List<Book> books = new ArrayList<>();

        books.add(this.getBook());
        books.add(this.getBook());
        return books;
    }

    public  Book getBookByJson(JSONObject book)
    {
        return new Book(
                (Integer) book.get("id"),
                (String) book.get("titleContent"),
                (String) book.get("imageUrl"),
                (String) book.get("date"),
                (String) book.get("authorName"),
                (String) book.get("editorName")
        );
    }

    public  Book getBookByWrapper(ResponseEntity<GBWrapper> entity)
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

    public Object getGoogleDetailISBN(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Book> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, Book.class);
        //System.out.println(entity.getBody().getItems()[0].getVolumeInfo().getPublisher());
       ///return entity.getBody().getItems()[0].getVolumeInfo().getPublisher();

        return  entity;
    }

    public String getGoogleDetailISBNS(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Book> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, Book.class);
        return isbn;
    }

    public Object getGoogleDetail(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);
    }

    public Book returnBookByJson(){
        JSONObject json = (JSONObject) this.getGoogleDetail();
        json.put("id", 1);
        return getBookByJson(json);
    }

    //Conversion wrapper into json book
    public JSONObject getGoogleDetailBook(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);

        JSONObject json = new JSONObject();
        json.put("id", 1);
        json.put("titleContent", entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        json.put("imageUrl", entity.getBody().getItems()[0].getVolumeInfo().getImageLinks());
        json.put("date", entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        json.put("authorName", entity.getBody().getItems()[0].getVolumeInfo().getAuthors());
        json.put("editorName", entity.getBody().getItems()[0].getVolumeInfo().getPublisher());
        return json;
    }

    public Book returnBookByJsonBook(){
        JSONObject json = this.getGoogleDetailBook();
        return getBookByJson(json);
    }

    public Book AllIn(){
        String isbn = "9380658745";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GBWrapper> entity = restTemplate.getForEntity("https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn, GBWrapper.class);

        /*JSONObject json = new JSONObject();
        json.put("id", 1);
        json.put("titleContent", entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        json.put("imageUrl", entity.getBody().getItems()[0].getVolumeInfo().getImageLinks());
        json.put("date", entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        json.put("authorName", entity.getBody().getItems()[0].getVolumeInfo().getAuthors());
        json.put("editorName", entity.getBody().getItems()[0].getVolumeInfo().getPublisher());*/

        String json = entity.toString();


        /*System.out.println(entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        System.out.println(entity.getBody().getItems()[0].getVolumeInfo().getImageLinks());
        System.out.println(entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        System.out.println(Arrays.toString(entity.getBody().getItems()[0].getVolumeInfo().getAuthors()));
        System.out.println(entity.getBody().getItems()[0].getVolumeInfo().getPublisher());

        Book book = new Book();
        book.setId(1);
        book.setTitleContent(entity.getBody().getItems()[0].getVolumeInfo().getTitle());
        book.setImageUrl("test");
        book.setDate(entity.getBody().getItems()[0].getVolumeInfo().getPublishedDate());
        book.setAuthorName(Arrays.toString(entity.getBody().getItems()[0].getVolumeInfo().getAuthors()));
        book.setEditorName(entity.getBody().getItems()[0].getVolumeInfo().getPublisher());*/
        return getBookByWrapper(entity);
       // return book;
        //return entity;
    }


}
