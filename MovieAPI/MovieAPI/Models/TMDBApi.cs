using System.Text.Json;

namespace MovieAPI.Models
{
    /// <summary>
    /// This class gets called by the runtime
    /// </summary>
    public static class TMDBApi
    {
        public static HttpClient? Client { get; set; }
        public static string? ApiKey { get; set; }
        public static string? Language { get; set; }
        public static JsonSerializerOptions? JsonSerializerOptions { get; set; }

        public static async Task<HttpResponseMessage> Get(string endpoint)
        {
            try
            {
                return await Client.GetAsync($"{endpoint}?api_key={ApiKey}&language={Language}&append_to_response=videos");
            }
            catch (Exception)
            {
                return new HttpResponseMessage
                {
                    StatusCode = System.Net.HttpStatusCode.NotFound
                };
            }
        }

        public static async Task<HttpResponseMessage> Search(string endpoint, string query)
        {
            try
            {
                return await Client.GetAsync($"{endpoint}?query={query}&api_key={ApiKey}&language={Language}&append_to_response=videos");
            }
            catch (Exception)
            {
                return new HttpResponseMessage
                {
                    StatusCode = System.Net.HttpStatusCode.NotFound
                };
            }
        }
        public static async Task<HttpResponseMessage> Popular(string endpoint)
        {
            try
            {
                return await Client.GetAsync($"{endpoint}/popular?api_key={ApiKey}&language={Language}&append_to_response=videos");
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
