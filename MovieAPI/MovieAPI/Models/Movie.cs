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
        public string? Image { get; set; }
        
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
