namespace MovieAPI.Models
{
    public class Movie
    {
        public int? id { get; set; }
        public string? title { get; set; }
        public bool? adult { get; set; }
        public string? poster_path { get; set; }
        public DateTime? release_date { get; set; }
        public float? vote_average { get; set; }
        public List<Genre>? genres { get; set; }
        public Credits? credits { get; set; }
    }
}
