using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Credits
    {
        [JsonPropertyName("id")]
        public int? Id { get; set; }

        [JsonPropertyName("cast")]
        public List<Actor>? Cast { get; set; }
    }
}
