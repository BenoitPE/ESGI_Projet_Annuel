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
        /// Get a serie
        /// </summary>
        /// <param name="id">The serie Id</param>
        /// <returns>Serie details</returns>
        [HttpGet("Get/{id}")]
        public async Task<IActionResult> Get(int id = 154521)
        {
            HttpResponseMessage response = await TMDBApi.Get($"tv/{id}");
            if (!response.IsSuccessStatusCode)
                return NotFound();

            Serie? serie = JsonSerializer.Deserialize<Serie>(
                await response.Content.ReadAsStringAsync(),
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
        /// <returns>A list of serie</returns>
        [HttpGet("Search/{query}")]
        public async Task<IActionResult> Search(string query = "Spiderman")
        {
            HttpResponseMessage response = await TMDBApi.Search($"search/tv", query);
            if (!response.IsSuccessStatusCode)
                return NotFound();

            SerieSearch? search = JsonSerializer.Deserialize<SerieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (search == null || search.Results == null || search.Results.Count == 0)
                return Ok(new List<Content>());

            if (search.Results.Count > 9)
                search.Results = search.Results.GetRange(0, 9);

            List<Content> serieList = new List<Content>();
            for (int i = 0; i < search.Results.Count; i++)
            {
                serieList.Add((Content)(await Get((int)search.Results[i].Id) as OkObjectResult).Value);
            }

            return Ok(serieList);
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

            SerieSearch? search = JsonSerializer.Deserialize<SerieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            if (search == null || search.Results == null || search.Results.Count == 0)
                return Ok(new List<Content>());

            if (search.Results.Count > 9)
                search.Results = search.Results.GetRange(0, 9);

            List<Content> serieList = new List<Content>();
            for (int i = 0; i < search.Results.Count; i++)
            {
                serieList.Add((Content)(await Get((int)search.Results[i].Id) as OkObjectResult).Value);
            }

            return Ok(serieList);
        }
    }
}