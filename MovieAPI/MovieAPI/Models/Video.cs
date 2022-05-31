namespace MovieAPI.Models
{
    public class Video
    {
        public string? Name { get; set; }
        public string? Key { get; set; }
        public string? TrailerUrl {
            get { return !string.IsNullOrWhiteSpace(Key) ? "https://www.youtube.com/watch?v=" + Key : null; }
        }
    }
}
