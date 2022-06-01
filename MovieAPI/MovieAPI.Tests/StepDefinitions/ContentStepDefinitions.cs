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
    public sealed class ContentStepDefinitions
    {
        private readonly ScenarioContext _scenarioContext;
        private bool _pointingOnMovie;
        private int _id;
        private string _name;
        private Content? _content;
        private List<Content>? _listContents;
        private OkObjectResult? _okObjectResult;
        private bool _notFound;
        private MovieController _movieController;
        private SerieController _serieController;

        public ContentStepDefinitions(ScenarioContext scenarioContext)
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
            _serieController = new SerieController(config);
            _notFound = false;
            _pointingOnMovie = false;
        }

        [Given(@"I'm pointing on (.*)")]
        public void GivenImPointingOnMovie(string contentType)
        {
            if(contentType.ToLower() == "movie")
                _pointingOnMovie=true;
        }


        [Given("an id (.*)")]
        public void GivenAnId(int id)
        {
            _id = id;
        }

        [Given(@"a search for (.*)")]
        public void GivenASearchForAMovieCalled(string query)
        {
            _name = query;
        }

        [When("I try to get data")]
        public void WhenITryToGetData()
        {
            IActionResult actionResult;
            if (_pointingOnMovie)
                actionResult = _movieController.Get(_id).Result;
            else
                actionResult = _serieController.Get(_id).Result;

            _okObjectResult = actionResult as OkObjectResult;

            if (_okObjectResult == null || _okObjectResult.StatusCode == 404)
                _notFound = true;
            else
                _content = (Content?)_okObjectResult.Value;
        }

        [When(@"I make a search")]
        public void WhenIMakeASearch()
        {
            IActionResult actionResult;
            if (_pointingOnMovie)
                actionResult = _movieController.Search(_name).Result;
            else
                actionResult = _serieController.Search(_name).Result;

            _okObjectResult = actionResult as OkObjectResult;

            if (_okObjectResult == null || _okObjectResult.StatusCode == 404)
                _notFound = true;
            else
                _listContents = (List<Content>?)_okObjectResult.Value;
        }

        [When(@"I want a list of popular content")]
        public void WhenIWantAListOfPopularContent()
        {
            IActionResult actionResult;
            if (_pointingOnMovie)
                actionResult = _movieController.Popular().Result;
            else
                actionResult = _serieController.Popular().Result;

            _okObjectResult = actionResult as OkObjectResult;

            if (_okObjectResult == null || _okObjectResult.StatusCode == 404)
                _notFound = true;
            else
                _listContents = (List<Content>?)_okObjectResult.Value;
        }

        [Then("I have data")]
        public void ThenIHaveData()
        {
            Assert.IsFalse(_notFound);
            Assert.AreNotEqual(_content, null);
            _content?.Id.Should().Be(_id);
        }

        [Then("no content was found")]
        public void ThenNoContentWasFound()
        {
            Assert.IsTrue(_notFound);
        }

        [Then(@"multiple results were found")]
        public void ThenMultipleResultsWereFound()
        {
            Assert.IsFalse(_notFound);
            Assert.IsTrue(_listContents?.Count > 0);
        }

        [Then(@"no results were found")]
        public void ThenNoResultsWereFound()
        {
            Assert.IsTrue(_notFound);
        }
    }
}