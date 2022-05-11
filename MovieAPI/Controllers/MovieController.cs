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
        private DirectoryInfo _logger;

        /// <summary>
        /// <see cref="MovieController"/> constructor
        /// </summary>
        /// <param name="logger"></param>
        /// <param name="config"></param>
        public MovieController(ILogger<MovieController> logger, IConfiguration config)
        {
            _config = config;
            _logger = new DirectoryInfo(_config.GetValue<string>("LoggerDirectory"));
        }

        /// <summary>
        /// Get a movie
        /// </summary>
        /// <param name="id">The movie Id</param>
        /// <returns>Movie details</returns>
        [HttpGet("Get/{id}")]
        public async Task<Movie> Get(int id = 634649)
        {

            HttpResponseMessage response = await TMDBApi.Get($"movie/{id}");
            //response.EnsureSuccessStatusCode();

            Movie? movie = JsonSerializer.Deserialize<Movie>(await (await TMDBApi.Get($"movie/{id}")).Content.ReadAsStringAsync());
            movie.credits = JsonSerializer.Deserialize<Credits>(await (await TMDBApi.Get($"movie/{id}/credits")).Content.ReadAsStringAsync());

            if (movie?.credits?.cast != null && movie?.credits?.cast?.Count > 9)
                movie.credits.cast = movie.credits.cast.Take(9).ToList();

            return movie;

        }

    }
}