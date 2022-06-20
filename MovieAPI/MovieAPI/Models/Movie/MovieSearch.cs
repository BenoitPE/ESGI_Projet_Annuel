using System.Text.Json;
using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class MovieSearch
    {
        public int? Page { get; set; }
        public List<Movie>? Results { get; set; }
    }
}
