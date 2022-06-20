using Microsoft.AspNetCore.Mvc;
using MovieAPI.Models;
using System.Text.Json;

namespace MovieAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MovieController : ControllerBase
    {
        private readonly IConfiguration _config;

        /// <summary>
        /// <see cref="MovieController"/> constructor
        /// </summary>
        /// <param name="config"></param>
        public MovieController(IConfiguration config)
        {
            _config = config;
        }

        /// <summary>
        /// Get a movie
        /// </summary>
        /// <param name="id">The movie Id</param>
        /// <returns>Movie details</returns>
        [HttpGet("Get/{id}")]
        public async Task<IActionResult> Get(int id = 634649)
        {
            HttpResponseMessage response = await TMDBApi.Get($"movie/{id}");
            if (!response.IsSuccessStatusCode)
                return NotFound();

            Movie? movie = JsonSerializer.Deserialize<Movie>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if(movie == null)
                return NotFound();

            movie.Credits = JsonSerializer.Deserialize<Credits>(
                await (await TMDBApi.Get($"movie/{id}/credits")).Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (movie.Credits != null && movie.Credits.Cast != null && movie.Credits.Cast.Count > 9)
                movie.Credits.Cast = movie.Credits.Cast.Take(9).ToList();

            return Ok(movie);
        }

        /// <summary>
        /// Search a movie
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>A list of movies</returns>
        [HttpGet("Search/{query}")]
        public async Task<IActionResult> Search(string query = "Spiderman")
        {
            HttpResponseMessage response = await TMDBApi.Search($"search/movie", query);
            if (!response.IsSuccessStatusCode)
                return NotFound();

            MovieSearch? searchResult = JsonSerializer.Deserialize<MovieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if(searchResult == null || searchResult.Results == null || searchResult.Results.Count == 0)
                return NotFound();

            if(searchResult.Results.Count > 9)
                searchResult.Results = searchResult.Results.GetRange(0, 9);

            for (int i = 0; i < searchResult.Results.Count; i++)
            {
                OkObjectResult result = await Get((int)searchResult.Results[i].Id) as OkObjectResult;
                searchResult.Results[i] = (Movie)result.Value;
            }

            return Ok(searchResult.Results);
        }

        /// <summary>
        /// Get popular movies
        /// </summary>
        /// <returns>A list of movies</returns>
        [HttpGet("Popular")]
        public async Task<IActionResult> Popular()
        {
            HttpResponseMessage response = await TMDBApi.Popular("movie");
            if (!response.IsSuccessStatusCode)
                return NotFound();

            string? res = await response.Content.ReadAsStringAsync();

            MovieSearch? searchResult = JsonSerializer.Deserialize<MovieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (searchResult == null || searchResult.Results == null || searchResult.Results.Count == 0)
                return NotFound();

            if (searchResult.Results.Count > 9)
                searchResult.Results = searchResult.Results.GetRange(0, 9);

            for (int i = 0; i < searchResult.Results.Count; i++)
            {
                OkObjectResult result = await Get((int)searchResult.Results[i].Id) as OkObjectResult;
                searchResult.Results[i] = (Movie)result.Value;
            }

            return Ok(searchResult.Results);
        }
    }
}