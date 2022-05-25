using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Movie
    {
        [JsonPropertyName("id")]
        public int? Id { get; set; }

        [JsonPropertyName("title")]
        public string? Title { get; set; }

        [JsonPropertyName("adult")]
        public bool? Adult { get; set; }

        [JsonPropertyName("poster_path")]
        private string? Image { get; set; }

        public string? ImageLowQuality
        {
            get { return "https://image.tmdb.org/t/p/w500" + Image; }
        }
        public string? ImageHighQuality
        {
            get { return "https://image.tmdb.org/t/p/original" + Image; }
        }

        [JsonPropertyName("release_date")]
        public DateTime? ReleaseDate { get; set; }

        [JsonPropertyName("vote_average")]
        public float? Vote { get; set; }

        [JsonPropertyName("genres")]
        public List<Genre>? Genres { get; set; }

        [JsonPropertyName("credits")]
        public Credits? Credits { get; set; }
    }
}
