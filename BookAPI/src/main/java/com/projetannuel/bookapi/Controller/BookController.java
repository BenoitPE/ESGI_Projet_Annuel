package com.projetannuel.bookapi.Controller;

import com.projetannuel.bookapi.Model.Book;
import com.projetannuel.bookapi.Service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BookController {

	@Autowired
	private BookService bookService;

	public static void main(String[] args) {

	}

	@GetMapping("/hello")
	public String sayHello(@RequestParam(value = "myName", defaultValue = "World") String name) {
		return String.format("Hello %s!", name);
	}

	@GetMapping("/books")
	public List<Book> books() {
		return bookService.buidBookListWithWrapper();
	}

	@GetMapping("/getBookFromApi")
	public Book getBookFromApi() {
		return bookService.returnBookFromGoogleApi();
	}

	@GetMapping("/getBookFromApiByAuthor")
	@ResponseBody
	public Book getBookFromApiByAuthor(@RequestParam String author) {
		return bookService.returnBookFromGoogleApiByTitle(author);
	}

	@GetMapping("/getBookFromApiByTitle")
	@ResponseBody
	public Book getBookFromApiByTitle(@RequestParam String title) {
		return bookService.returnBookFromGoogleApiByAuthor(title);
	}

}
