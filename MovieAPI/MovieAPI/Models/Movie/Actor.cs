using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Actor
    {
        public string? Character { get; set; }
        public string? Profile_path { get; set; }
        public int? Id { get; set; }
        public int? Gender { get; set; }
        public string? Name { get; set; }
        public string? ImageUrl
        {
            get { return !string.IsNullOrWhiteSpace(Profile_path) ? "https://image.tmdb.org/t/p/w185" + Profile_path : null; }
        }
    }
}
