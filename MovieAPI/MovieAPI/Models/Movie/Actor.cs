using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Actor
    {
        public int? Gender { get; set; }
        public string? Name { get; set; }
        public string? Character { get; set; }

        private string? _profile_path;
        public string? Profile_path {
            get
            {
                return "https://image.tmdb.org/t/p/w185" + _profile_path;
            }
            set
            {
                _profile_path = value;
            }
        }
    }
}
