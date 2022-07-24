using Microsoft.AspNetCore.Mvc;
using MovieAPI.Models;
using MovieAPI.Services;
using System.Text.Json;

namespace MovieAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MovieController : ControllerBase
    {
        private readonly IConfiguration _config;
        private MovieService _movieService;

        /// <summary>
        /// <see cref="MovieController"/> constructor
        /// </summary>
        /// <param name="config"></param>
        public MovieController(IConfiguration config)
        {
            _config = config;
            _movieService = new MovieService();
        }

        /// <summary>
        /// Get a movie
        /// </summary>
        /// <param name="id">The movie Id</param>
        /// <returns>IActionResult</returns>
        [HttpGet("Get/{id}")]
        public async Task<IActionResult> Get(int id = 634649)
        {
            Content? content = await _movieService.Get(id);
            if(content == null)
                return NotFound();

            return Ok(content);
        }

        /// <summary>
        /// Search a movie
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>IActionResult</returns>
        [HttpGet("Search/{query}")]
        public async Task<IActionResult> Search(string query = "Spiderman")
        {
            List<Content>? contents = await _movieService.Search(query);
            if (contents == null)
                return NotFound();

            return Ok(contents);
        }

        /// <summary>
        /// Get popular movies
        /// </summary>
        /// <returns>IActionResult</returns>
        [HttpGet("Popular")]
        public async Task<IActionResult> Popular()
        {
            List<Content>? contents = await _movieService.Popular();
            if (contents == null)
                return NotFound();

            return Ok(contents);
        }
    }
}