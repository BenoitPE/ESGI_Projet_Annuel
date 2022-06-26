package com.projetannuel.bookapi.Controller;

import com.projetannuel.bookapi.Model.Book;
import com.projetannuel.bookapi.Service.BookService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

	@GetMapping("/test")
	public Map<String, String> sayHello() {
		HashMap<String, String> map = new HashMap<>();
		map.put("key", "value");
		map.put("foo", "bar");
		map.put("aa", "bb");
		return map;
	}

	@GetMapping("/BOOKJSONOBJECT")
	public Book bookJSONOBJECT() {
		JSONObject json = new JSONObject();
		json.put("id", 1);
		json.put("titleContent", "test");
		json.put("imageUrl", "jLien");
		json.put("date", new Date(1 / 1999));
		json.put("authorName", "question");
		json.put("editorName", "sondage");

		return bookService.getBookByJson(json);
	}

	@GetMapping("/BOOKJSON")
	public Book bookJSON() {
		HashMap<String, String> map = new HashMap<>();
		map.put("titleContent", "test");
		map.put("imageUrl", "Lien");
		map.put("authorName", "question");
		map.put("editorName", "sondage");

		return new Book(
				1,
				map.get("titleContent"),
				map.get(""),
				String.valueOf(new Date(1 / 1999)),
				map.get(""),
				map.get("editorName")
				);

	}

	@GetMapping("/book")
	public Book book() {
		return bookService.getBook();
	}

	@GetMapping("/books")
	public List<Book> books() {
		return bookService.getBooks();
	}

	@GetMapping("/string")
	public String string() {
		return bookService.string();
	}

	@GetMapping("/BOOKGoogle")
	public Object bookJSONGoogle() {
		return bookService.getGoogleDetailISBN();
	}

	@GetMapping("/BOOKGoogles")
	public String bookJSONGoogles() {
		return bookService.getGoogleDetailISBNS();
	}

	@GetMapping("/testbook")
	public Object testbook() {
		return bookService.getGoogleDetail();
	}

	@GetMapping("/ReturnBook")
	public Book returnBook() {
		return bookService.returnBookByJson();
	}

	@GetMapping("/ReturnBookByJson")
	public Book returnBookByJson() {
		return bookService.returnBookByJsonBook();
	}


	@GetMapping("/AllIn")
	public Book AllIn() {
		return bookService.AllIn();
	}

	//exemple liste objet
/*	@GetMapping(path = "/hello", produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Object> sayHello()
	{
		//Get data from service layer into entityList.

		List<JSONObject> entities = new ArrayList<JSONObject>();
		for (Entity n : entityList) {
			JSONObject entity = new JSONObject();
			entity.put("aa", "bb");
			entities.add(entity);
		}
		return new ResponseEntity<Object>(entities, HttpStatus.OK);
	}*/

}
