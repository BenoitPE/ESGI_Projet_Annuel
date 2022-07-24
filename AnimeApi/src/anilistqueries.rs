use serde_json::{json, Value};
use reqwest::Client;
use std::fs::File;
use std::io::Read;
use crate::Anime;

pub fn read_query(filename: String) -> String {
    let mut graphql_query = String::new();
    let file_path = format!("./queries/{}", filename);
    File::open(file_path)
        .and_then(|mut file| file.read_to_string(&mut graphql_query))
        .unwrap();
    graphql_query
}

pub async fn get_anime_request(json: Value) -> serde_json::Value {
    let client = Client::new();
    // Make HTTP post request
    let resp = client.post("https://graphql.anilist.co/")
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .body(json.to_string())
        .send()
        .await
        .unwrap()
        .text()
        .await;
    // Get json
    let result: serde_json::Value = serde_json::from_str(&resp.unwrap()).unwrap();
    result
}

pub async fn get_anime(data: String, requestType: String) -> String {
    let graphql_query = read_query("get_anime_query.graphql".to_string());
    let json = json!({"query": graphql_query, "variables": {requestType: data}});
    Anime::parse(get_anime_request(json).await)
}

pub async fn get_trending_anime() -> String {
    let graphql_query = read_query("get_trending_anime_query.graphql".to_string());
    let json = json!({"query": graphql_query, "variables": {"page": 1,"perPage": 10}});
    Anime::parse(get_anime_request(json).await)
}