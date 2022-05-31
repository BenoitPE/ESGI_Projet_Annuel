﻿using System.Text.Json.Serialization;

namespace MovieAPI.Models
{
    public class Movie
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public bool? Adult { get; set; }
        public string? Poster_path { get; set; }
        public DateTime? Release_date { get; set; }
        public List<Genre>? Genres { get; set; }
        public Credits? Credits { get; set; }
        public Videos? Videos { get; set; }
        public string? ImageUrl
        {
            get { return !string.IsNullOrWhiteSpace(Poster_path) ? "https://image.tmdb.org/t/p/original" + Poster_path : null; }
        }
        public DateTime? Date
        {
            get { return (Release_date != null) ? Release_date : null; }
        }
        public string? TrailerUrl
        {
            get
            {
                if (Videos != null && Videos.Results != null && Videos.Results.Count > 0)
                    return Videos.Results[0].TrailerUrl;
                else return null;
            }
        }
    }
}
