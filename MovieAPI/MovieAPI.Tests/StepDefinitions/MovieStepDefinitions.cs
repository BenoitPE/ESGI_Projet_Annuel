using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MovieAPI.Controllers;
using MovieAPI.Models;
using NUnit.Framework;
using System.Net.Http.Headers;

namespace MovieAPI.Tests.StepDefinitions
{
    [Binding]
    public sealed class MovieStepDefinitions
    {
        private readonly ScenarioContext _scenarioContext;
        private int _movieId;
        private Content? _content;
        private OkObjectResult? _okObjectResult;
        private bool _notFound;
        private MovieController _movieController;

        public MovieStepDefinitions(ScenarioContext scenarioContext)
        {
            var config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: false)
                .Build();

            TMDBApi.Client = new HttpClient
            {
                BaseAddress = new Uri(config.GetValue<string>("ApiBaseAddress"))
            };
            TMDBApi.Client.DefaultRequestHeaders.Accept.Clear();
            TMDBApi.Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            TMDBApi.ApiKey = config.GetValue<string>("ApiKey");
            TMDBApi.Language = config.GetValue<string>("Language");
            TMDBApi.JsonSerializerOptions = new System.Text.Json.JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            };

            _scenarioContext = scenarioContext;
            _movieController = new MovieController(config);
            _notFound = false;
        }

        [Given("a movie id is (.*)")]
        public void GivenAMovieIdIs(int id)
        {
            _movieId = id;
        }

        [When("I try to get this movie")]
        public void WhenITryToGetThisMovie()
        {
            IActionResult actionResult = _movieController.Get(_movieId).Result;
            _okObjectResult = actionResult as OkObjectResult;

            if (_okObjectResult == null || _okObjectResult.StatusCode == 404)
                _notFound = true;
            else
                _content = (Content?)_okObjectResult.Value;

        }

        [Then("I have the data from the movie")]
        public void ThenIHaveTheDataFromTheMovie()
        {
            Assert.IsFalse(_notFound);
            Assert.AreNotEqual(_content, null);
            Assert.AreNotEqual(_content?.Movie, null);
            _content?.Id.Should().Be(_movieId);
        }

        [Then("no movie was found")]
        public void ThenNoMovieWasFound()
        {
            Assert.IsTrue(_notFound);
        }
    }
}