using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Actor
    {
        
        [JsonPropertyName("id")]
        public int? Id { get; set; }

        [JsonPropertyName("gender")]
        public int? Gender{ get; set; }

        [JsonPropertyName("know_for_department")]
        public string? know_for_department { get; set; }

        [JsonPropertyName("name")]
        public string? name { get; set; }

        [JsonPropertyName("profile_path")]
        public string? Image { get; set; }

        [JsonPropertyName("character")]
        public string? Character { get; set; }

        [JsonPropertyName("order")]
        public int? Order { get; set; }
    }
}
