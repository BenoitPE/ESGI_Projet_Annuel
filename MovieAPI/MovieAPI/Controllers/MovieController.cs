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
                await (await TMDBApi.Get($"movie/{id}")).Content.ReadAsStringAsync(), 
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
    }
}