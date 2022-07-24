use serde_json;
use serde::{Serialize, Deserialize};
use chrono::{TimeZone};
use serde_json::Value;

#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct Anime {
    id: Option<String>,
    title: Option<String>,
    overview: Option<String>,
    date: Option<String>,
    imageUrl: Option<String>,
    mediaType: Option<String>,
    adult: Option<bool>,
    properties: Properties,
}

#[derive(Debug, Default, Clone, Serialize, Deserialize)]
struct Character {
    gender: Option<String>,
    id: Option<i64>,
    profile_path: Option<String>,
    name: Option<String>,
}

#[derive(Debug, Default, Clone, Serialize, Deserialize)]
struct Properties {
    episodes: Option<i64>,
    duration: Option<i64>,
    genres: Option<Vec<String>>,
    characters: Option<Vec<Character>>,
}

pub fn parse(datas: Value) -> String {
    let mut vec_anime: Vec<Anime> = Vec::new();
    if let Some(data) = datas["data"].as_object() {
        if let Some(page) = data["Page"].as_object() {
            if let Some(medias) = page["media"].as_array() {
                for item in medias
                {
                    let mut anime = Anime::default();
                    anime.mediaType = Some("anime".to_string());

                    if let Some(id) = item["id"].as_i64() {
                        anime.id = Some(id.to_string());
                    }

                    if let Some(title) = item["title"].as_object().unwrap()["english"].as_str() {
                        anime.title = Some(title.to_string());
                    } else {
                        if let Some(title) = item["title"].as_object().unwrap()["romaji"].as_str() {
                            anime.title = Some(title.to_string());
                        }
                    }

                    if let Some(description) = item["description"].as_str() {
                        anime.overview = Some(description.to_string());
                    }

                    if let Some(episodes) = item["episodes"].as_i64() {
                        anime.properties.episodes = Some(episodes);
                    }

                    if let Some(duration) = item["duration"].as_i64() {
                        anime.properties.duration = Some(duration);
                    }

                    if let Some(cover) = item["coverImage"].as_object().unwrap()["extraLarge"].as_str() {
                        anime.imageUrl = Some(cover.to_string());
                    }

                    if let Some(is_adult) = item["isAdult"].as_bool() {
                        anime.adult = Some(is_adult);
                    }

                    if let Some(genres) = item["genres"].as_array() {
                        let mut vec_genres: Vec<String> = vec![];

                        for genre in genres {
                            vec_genres.push(genre.as_str().unwrap().to_string());
                        }
                        if vec_genres.len() > 0 {
                            anime.properties.genres = Some(vec_genres);
                        }
                    }

                    if let Some(start_date) = item["startDate"].as_object() {
                        let mut year: i64 = 0;
                        let mut month: i64 = 1;
                        let mut day: i64 = 1;

                        if let Some(tmpyear) = start_date["year"].as_i64() {
                            year = Some(tmpyear).unwrap();
                        }
                        if let Some(tmpmonth) = start_date["month"].as_i64() {
                            month = Some(tmpmonth).unwrap();
                        }
                        if let Some(tmpday) = start_date["day"].as_i64() {
                            day = Some(tmpday).unwrap();
                        }
                        if year != 0 {
                            anime.date = Some(chrono::Utc.ymd(year as i32, month as u32, day as u32).format("%Y-%m-%d").to_string());
                        }

                        if let Some(characters) = item["characters"].as_object() {
                            if let Some(nodes) = characters["nodes"].as_array() {
                                let mut vec_character: Vec<Character> = vec![];

                                for node in nodes {
                                    let mut character = Character::default();
                                    if let Some(gender) = node["gender"].as_str() {
                                        character.gender = Some(gender.to_string());
                                    }
                                    if let Some(id) = node["id"].as_i64() {
                                        character.id = Some(id);
                                    }
                                    if let Some(image) = node["image"].as_object().unwrap()["medium"].as_str() {
                                        character.profile_path = Some(image.to_string());
                                    }
                                    if let Some(name) = node["name"].as_object().unwrap()["userPreferred"].as_str() {
                                        character.name = Some(name.to_string());
                                    }
                                    vec_character.push(character);
                                }

                                if vec_character.len() > 0 {
                                    anime.properties.characters = Some(vec_character);
                                }
                            }
                        }
                    }
                    vec_anime.push(anime);
                }
            }
        }
    }
    if vec_anime.len() <= 0 {
        "".to_string()
    } else if vec_anime.len() == 1 {
        serde_json::to_string(&vec_anime[0]).unwrap()
    }
    else {
        serde_json::to_string(&vec_anime).unwrap()
    }
}