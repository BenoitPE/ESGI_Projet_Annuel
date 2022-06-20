using System.Text.Json;
using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class SerieSearch
    {
        public int? Page { get; set; }
        public List<Serie>? Results { get; set; }
    }
}
