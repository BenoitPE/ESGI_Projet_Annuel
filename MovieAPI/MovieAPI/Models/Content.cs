namespace MovieAPI.Models
{
    public class Content
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public string? ImageUrl { get; set; }
        public string? Date { get; set; }
        public string? Anime { get; set; }
        public string? Book { get; set; }
        public Movie? Movie { get; set; }
        public Serie? Serie { get; set; }

        public Content(Movie movie)
        {
            Id = movie.Id;
            Title = movie.Title;
            ImageUrl = movie.ImageUrl;
            Date = movie.Date;
            Movie = movie;
        }

        public Content(Serie serie)
        {
            Id = serie.Id;
            Title = serie.Name;
            ImageUrl = serie.ImageUrl;
            Date = serie.Date;
            Serie = serie;
        }

        public static List<Content> ToContent(List<Movie> movies)
        {
            List<Content> contents = new List<Content>();
            foreach(Movie movie in movies)
            {
                contents.Add(new Content(movie));
            }
            return contents;
        }
    }
}
