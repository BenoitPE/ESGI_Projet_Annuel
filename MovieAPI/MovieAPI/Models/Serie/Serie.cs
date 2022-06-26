namespace MovieAPI.Models
{
    public class Serie
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public bool? Adult { get; set; }
        public string? Poster_path { get; set; }
        public string? First_air_date { get; set; }
        public List<Genre>? Genres { get; set; }
        public Credits? Credits { get; set; }
        public string? Overview { get; set; }
        public Videos? Videos { get; set; }
        public List<Season>? Seasons { get; set; }
        public string? ImageUrl
        {
            get { return !string.IsNullOrWhiteSpace(Poster_path) ? "https://image.tmdb.org/t/p/original" + Poster_path : null; }
        }
        public string? Date
        {
            get { return string.IsNullOrWhiteSpace(First_air_date) ? First_air_date : null; }
        }
        public string? TrailerUrl
        {
            get
            {
                return Videos != null && Videos.Results != null && Videos.Results.Count > 0 ? Videos.Results[0].TrailerUrl : null;
            }
        }
        public string? Title
        {
            get { return !string.IsNullOrWhiteSpace(Name) ? Name : null; }
        }
    }
}
