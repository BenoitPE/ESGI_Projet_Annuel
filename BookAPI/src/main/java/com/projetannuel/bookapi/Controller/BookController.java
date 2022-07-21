package com.projetannuel.bookapi.Controller;

import com.projetannuel.bookapi.Model.Book;
import com.projetannuel.bookapi.Service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BookController {

	@Autowired
	private BookService bookService;

	public static void main(String[] args) {

	}

	@GetMapping(path = "/getBookFromApiByIsbn",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Book> getBookFromApi(@RequestParam String isbn) {
      Book result = bookService.returnBookFromGoogleApiByIsbn(isbn);
      ResponseEntity<Book> response;
      if(null != result){
         response = ResponseEntity.status(HttpStatus.OK).body(result);
      }else{
         response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
      }
		return response;
	}

	@GetMapping(path = "/getBookFromApiByTitle",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Book> getBookFromApiByTitle(@RequestParam String title) {
      Book result = bookService.returnBookFromGoogleApiByTitle(title);
      ResponseEntity<Book> response;
      if(null != result){
         response = ResponseEntity.status(HttpStatus.OK).body(result);
      }else{
         response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
      }
		return response;
	}

	@GetMapping(path = "/getBooksFromApi",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<Book>> getBooksFromApi() {
      List<Book> result = bookService.returnBooksFromGoogleApi();
      ResponseEntity<List<Book>> response;
      if(result.size() > 0){
         response = ResponseEntity.status(HttpStatus.OK).body(result);
      }else{
         response = ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
      }
		return response;
	}
}
