using MovieAPI.Models;
using System.Text.Json;

namespace MovieAPI.Services
{
    public class SerieService
    {
        /// <summary>
        /// Get a serie
        /// </summary>
        /// <param name="id">The serie Id</param>
        /// <returns>Content with Serie properties</returns>
        public async Task<Content?> Get(int id)
        {
            HttpResponseMessage response = await TMDBApi.Get($"tv/{id}");

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into Serie
            Serie? serie = JsonSerializer.Deserialize<Serie>(
                await response.Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Checks if success
            if (serie == null)
                return null;

            // Adds Serie credits
            serie.Credits = JsonSerializer.Deserialize<Credits>(
                await (await TMDBApi.Get($"tv/{id}/credits")).Content.ReadAsStringAsync(),
                TMDBApi.JsonSerializerOptions);

            // Takes the first nine characters
            if (serie.Credits != null && serie.Credits.Cast != null && serie.Credits.Cast.Count > 9)
                serie.Credits.Cast = serie.Credits.Cast.Take(9).ToList();

            return new Content(serie);
        }

        /// <summary>
        /// Search a content
        /// </summary>
        /// <param name="query">The query (e.g: "Spiderm")</param>
        /// <returns>A list of Content</returns>
        public async Task<List<Content>?> Search(string query)
        {
            HttpResponseMessage response = await TMDBApi.Search($"search/tv", query);

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into SerieSearch
            SerieSearch? search = JsonSerializer.Deserialize<SerieSearch>(
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
        /// Get popular series
        /// </summary>
        /// <returns>A list of Content</returns>
        public async Task<List<Content>?> Popular()
        {
            HttpResponseMessage response = await TMDBApi.Popular("tv");

            // Checks if the response from TMDB Api is correct
            if (!response.IsSuccessStatusCode)
                return null;

            // Deserializing the response into SerieSearch
            SerieSearch? search = JsonSerializer.Deserialize<SerieSearch>(
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
