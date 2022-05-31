using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Credits
    {
        public int? Id { get; set; }
        public List<Actor>? Cast { get; set; }
    }
}
