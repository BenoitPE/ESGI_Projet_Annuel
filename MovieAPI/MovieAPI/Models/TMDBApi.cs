﻿namespace MovieAPI.Models
{
    /// <summary>
    /// This class gets called by the runtime
    /// </summary>
    public static class TMDBApi
    {
        public static HttpClient Client { get; set; }
        public static string ApiKey { get; set; }
        public static string Language { get; set; }

        public static async Task<HttpResponseMessage> Get(string endpoint)
        {
            try
            {
                return await Client.GetAsync($"{endpoint}?api_key={ApiKey}&language={Language}");
            }
            catch (Exception)
            {
                return new HttpResponseMessage
                {
                    StatusCode = System.Net.HttpStatusCode.NotFound
                };
            }
        }

    }
}
