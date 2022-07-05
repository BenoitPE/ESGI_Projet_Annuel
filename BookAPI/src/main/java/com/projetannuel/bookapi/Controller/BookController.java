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

	@GetMapping("/getBookFromApiById")
	@ResponseBody
	public Book getBookFromApi(@RequestParam String id) {
		return bookService.returnBookFromGoogleApiById(id);
	}

	@GetMapping("/getBookFromApiByTitle")
	@ResponseBody
	public Book getBookFromApiByTitle(@RequestParam String title) {
		return bookService.returnBookFromGoogleApiByTitle(title);
	}

	@GetMapping("/getBooksFromApi")
	public List<Book> getBooksFromApi() {
		return bookService.returnBooksFromGoogleApi();
	}

}
