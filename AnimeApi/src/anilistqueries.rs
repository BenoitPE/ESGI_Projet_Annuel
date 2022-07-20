use serde_json::json;
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

pub async fn get_anime_request(data: String, requestType: String) -> serde_json::Value {
    let client = Client::new();
    let graphql_query = read_query("get_anime_query.graphql".to_string());
    let json = json!({"query": graphql_query, "variables": {requestType: data}});
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
    Anime::parse(get_anime_request(data, requestType).await)
}