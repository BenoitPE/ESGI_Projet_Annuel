using Microsoft.AspNetCore.Mvc;
using MovieAPI.Models;
using MovieAPI.Services;
using System.Text.Json;

namespace MovieAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SerieController : ControllerBase
    {
        private readonly IConfiguration _config;
        private SerieService _serieService;

        /// <summary>
        /// <see cref="SerieController"/> constructor
        /// </summary>
        /// <param name="config"></param>
        public SerieController(IConfiguration config)
        {
            _config = config;
            _serieService = new SerieService();
        }

        /// <summary>
        /// Get a serie
        /// </summary>
        /// <param name="id">The serie Id</param>
        /// <returns>IActionResult</returns>
        [HttpGet("Get/{id}")]
        public async Task<IActionResult> Get(int id = 154521)
        {
            Content? content = await _serieService.Get(id);
            if (content == null)
                return NotFound();

            return Ok(content);
        }

        /// <summary>
        /// Search a content
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>IActionResult</returns>
        [HttpGet("Search/{query}")]
        public async Task<IActionResult> Search(string query = "Spiderman")
        {
            List<Content>? contents = await _serieService.Search(query);
            if (contents == null)
                return NotFound();

            return Ok(contents);
        }

        /// <summary>
        /// Get popular series
        /// </summary>
        /// <returns>IActionResult</returns>
        [HttpGet("Popular")]
        public async Task<IActionResult> Popular()
        {
            List<Content>? contents = await _serieService.Popular();
            if (contents == null)
                return NotFound();

            return Ok(contents);
        }
    }
}