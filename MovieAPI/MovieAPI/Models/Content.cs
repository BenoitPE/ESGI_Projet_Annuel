namespace MovieAPI.Models
{
    public class Content
    {
        public string MediaType { get; set; }
        public string? Id { get; set; }
        public string? Title { get; set; }
        public string? Date { get; set; }
        public bool? Adult { get; set; }
        public string? ImageUrl { get; set; }
        public List<string> Genres { get; set; }
        public string? Overview { get; set; }
        public Dictionary<string, object?> Properties { get; set; }

        public Content(Movie movie)
        {
            MediaType = "Movie";
            Id = movie.Id != null ? movie.Id.ToString() : null;
            Title = movie.Title;
            Date = movie.Release_date;
            ImageUrl = movie.ImageUrl;
            Adult = movie.Adult;
            Overview = movie.Overview;
            Genres = new List<string>();

            if (movie.Genres == null)
                Genres = new List<string>();
            else
                foreach (Genre genre in movie.Genres)
                    if (genre.Name != null)
                        Genres.Add(genre.Name);

            Properties = new();
            Properties.Add("trailerUrl", movie.TrailerUrl);
            Properties.Add("characters", movie.Credits?.Cast);
        }

        public Content(Serie serie)
        {
            //Id = serie.Id != null ? serie.Id.ToString() : null;
            //Title = serie.Name;
            //ImageUrl = serie.ImageUrl;
            //Date = serie.Date;
            //Properties = new();
            //Properties.Add("trailerUrl", serie.TrailerUrl);
            //Properties.Add("characters", serie.Credits?.Cast);

            MediaType = "Serie";
            Id = serie.Id != null ? serie.Id.ToString() : null;
            Title = serie.Name;
            Date = serie.First_air_date;
            ImageUrl = serie.ImageUrl;
            Adult = serie.Adult;
            Overview = serie.Overview;
            Genres = new List<string>();

            if (serie.Genres == null)
                Genres = new List<string>();
            else
                foreach (Genre genre in serie.Genres)
                    if (genre.Name != null)
                        Genres.Add(genre.Name);

            Properties = new();
            Properties.Add("trailerUrl", serie.TrailerUrl);
            Properties.Add("characters", serie.Credits?.Cast);
            Properties.Add("seasons", serie.Seasons);
        }
    }
}
