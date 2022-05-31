using MovieAPI.Models;
using System.Net.Http.Headers;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

var config = new ConfigurationBuilder()
        .AddJsonFile("appsettings.json", optional: false)
        .Build();

//Configuration of HttpClient for TMDB API
TMDBApi.Client = new HttpClient();
TMDBApi.Client.BaseAddress = new Uri(config.GetValue<string>("ApiBaseAddress"));
TMDBApi.Client.DefaultRequestHeaders.Accept.Clear();
TMDBApi.Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
TMDBApi.ApiKey = config.GetValue<string>("ApiKey");
TMDBApi.Language = config.GetValue<string>("Language");
Console.WriteLine("Connection with TMDB API established");

//    PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase,
TMDBApi.JsonSerializerOptions = new System.Text.Json.JsonSerializerOptions
{
    PropertyNameCaseInsensitive = true
};

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
