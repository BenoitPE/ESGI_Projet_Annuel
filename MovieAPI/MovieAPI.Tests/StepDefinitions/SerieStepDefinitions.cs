using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MovieAPI.Controllers;
using MovieAPI.Models;
using NUnit.Framework;
using System.Net.Http.Headers;

namespace MovieAPI.Tests.StepDefinitions
{
    [Binding]
    public sealed class SerieStepDefinitions
    {
        private readonly ScenarioContext _scenarioContext;
        private int _serieId;
        private Content? _content;
        private OkObjectResult? _okObjectResult;
        private bool _notFound;
        private SerieController _serieController;

        public SerieStepDefinitions(ScenarioContext scenarioContext)
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
            _serieController = new SerieController(config);
            _notFound = false;
        }

        [Given("a serie id is (.*)")]
        public void GivenASerieIdIs(int id)
        {
            _serieId = id;
        }

        [When("I try to get this serie")]
        public void WhenITryToGetThisSerie()
        {
            IActionResult actionResult = _serieController.Get(_serieId).Result;
            _okObjectResult = actionResult as OkObjectResult;

            if (_okObjectResult == null || _okObjectResult.StatusCode == 404)
                _notFound = true;
            else
                _content = (Content?)_okObjectResult.Value;

        }

        [Then("I have the data from the serie")]
        public void ThenIHaveTheDataFromTheSerie()
        {
            Assert.IsFalse(_notFound);
            Assert.AreNotEqual(_content, null);
            Assert.AreNotEqual(_content?.Serie, null);
            _content?.Id.Should().Be(_serieId);
        }

        [Then("no serie was found")]
        public void ThenNoSerieWasFound()
        {
            Assert.IsTrue(_notFound);
        }
    }
}