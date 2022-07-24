using Microsoft.AspNetCore.Mvc;
using MovieAPI.Models;
using System.Text.Json;

namespace MovieAPI.Services
{
    public class MovieService
    {
        /// <summary>
        /// Get a movie
        /// </summary>
        /// <param name="id">The movie Id</param>
        /// <returns>Content with movie properties</returns>
        public async Task<Content?> Get(int id)
        {
            HttpResponseMessage response = await TMDBApi.Get($"movie/{id}");

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into Movie
            Movie? movie = JsonSerializer.Deserialize<Movie>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Checks if success
            if (movie == null)
                return null;

            // Adds movie credits
            movie.Credits = JsonSerializer.Deserialize<Credits>(
                await (await TMDBApi.Get($"movie/{id}/credits")).Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Takes the first nine characters
            if (movie.Credits != null && movie.Credits.Cast != null && movie.Credits.Cast.Count > 9)
                movie.Credits.Cast = movie.Credits.Cast.Take(9).ToList();

            return new Content(movie);
        }

        /// <summary>
        /// Search a movie
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>A list of Content</returns>
        public async Task<List<Content>?> Search(string query)
        {
            HttpResponseMessage response = await TMDBApi.Search($"search/movie", query);

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into MovieSearch
            MovieSearch? search = JsonSerializer.Deserialize<MovieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Checks if empty result
            if (search == null || search.Results == null || search.Results.Count == 0)
                return new List<Content>();

            // Takes first nine elements
            if (search.Results.Count > 9)
                search.Results = search.Results.GetRange(0, 9);

            // Convert to a List of Content
            List<Content> contents = new List<Content>();
            for (int i = 0; i < search.Results.Count; i++)
            {
                Content? content = await Get((int)search.Results[i].Id);
                if (content != null && !String.IsNullOrWhiteSpace(content?.Date))
                    contents.Add(content);
            }

            // Sort by Date
            contents = MovieAPI.Models.Content.MergeSort(contents);

            return contents;
        }

        /// <summary>
        /// Get popular movies
        /// </summary>
        /// <returns>A list of Content</returns>
        public async Task<List<Content>?> Popular()
        {
            HttpResponseMessage response = await TMDBApi.Popular("movie");

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into MovieSearch
            MovieSearch? search = JsonSerializer.Deserialize<MovieSearch>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Checks if empty result
            if (search == null || search.Results == null || search.Results.Count == 0)
                return new List<Content>();

            // Takes first nine elements
            if (search.Results.Count > 9)
                search.Results = search.Results.GetRange(0, 9);

            // Convert to a List of Content
            List<Content> contents = new List<Content>();
            for (int i = 0; i < search.Results.Count; i++)
            {
                Content? content = await Get((int)search.Results[i].Id);
                if (content != null && !String.IsNullOrWhiteSpace(content?.Date))
                    contents.Add(content);
            }

            // Sort by Date
            contents = MovieAPI.Models.Content.MergeSort(contents);

            return contents;
        }
    }
}
