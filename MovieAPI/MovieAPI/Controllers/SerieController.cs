using Microsoft.AspNetCore.Mvc;
using MovieAPI.Models;
using System.Text.Json;

namespace MovieAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SerieController : ControllerBase
    {
        private readonly IConfiguration _config;

        /// <summary>
        /// <see cref="SerieController"/> constructor
        /// </summary>
        /// <param name="config"></param>
        public SerieController(IConfiguration config)
        {
            _config = config;
        }

        /// <summary>
        /// Get a movie
        /// </summary>
        /// <param name="id">The movie Id</param>
        /// <returns>Movie details</returns>
        [HttpGet("Get/{id}")]
        public async Task<IActionResult> Get(int id = 154521)
        {
            HttpResponseMessage response = await TMDBApi.Get($"tv/{id}");
            if (!response.IsSuccessStatusCode)
                return NotFound();

            Serie? serie = JsonSerializer.Deserialize<Serie>(
                await (await TMDBApi.Get($"tv/{id}")).Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (serie == null)
                return NotFound();

            serie.Credits = JsonSerializer.Deserialize<Credits>(
                await (await TMDBApi.Get($"tv/{id}/credits")).Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (serie.Credits != null && serie.Credits.Cast != null && serie.Credits.Cast.Count > 9)
                serie.Credits.Cast = serie.Credits.Cast.Take(9).ToList();

            return Ok(new Content(serie));
        }

        /// <summary>
        /// Search a content
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>A list of movies</returns>
        [HttpGet("Search/{query}")]
        public async Task<IActionResult> Search(string query = "Spiderman")
        {
            HttpResponseMessage response = await TMDBApi.Search($"search/tv", query);
            if (!response.IsSuccessStatusCode)
                return NotFound();

            string? res = await response.Content.ReadAsStringAsync();

            Search? searchResult = JsonSerializer.Deserialize<Search>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (searchResult == null || searchResult.Results == null)
                return NotFound();

            if (searchResult.Results.Count == 0)
                return NotFound();

            return Ok(Models.Content.ToContent(searchResult.Results));
        }


        /// <summary>
        /// Get popular series
        /// </summary>
        /// <returns>A list of series</returns>
        [HttpGet("Popular")]
        public async Task<IActionResult> Popular()
        {
            HttpResponseMessage response = await TMDBApi.Popular("tv");
            if (!response.IsSuccessStatusCode)
                return NotFound();

            string? res = await response.Content.ReadAsStringAsync();

            Search? searchResult = JsonSerializer.Deserialize<Search>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (searchResult == null || searchResult.Results == null)
                return NotFound();

            if (searchResult.Results.Count == 0)
                return NotFound();

            return Ok(Models.Content.ToContent(searchResult.Results));
        }
    }
}