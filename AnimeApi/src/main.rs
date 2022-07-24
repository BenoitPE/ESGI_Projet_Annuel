#[macro_use]
extern crate rocket;

mod anilistqueries;
mod anime;

use rocket::{Rocket, Request, Build};
use rocket::response::{status};
use rocket::http::Status;

#[get("/anime?<id>", rank = 1)]
async fn get_anime_by_id(id: i64) -> String {
    anilistqueries::get_anime(id.to_string(), "id".to_string())
        .await
}

#[get("/anime?<name>", rank = 2)]
async fn get_anime_by_name(name: String) -> String {
    anilistqueries::get_anime(name, "search".to_string())
        .await
}

#[get("/popular")]
async fn get_trending() -> String {
    anilistqueries::get_trending_anime()
        .await
}

#[catch(default)]
fn default_catcher(status: Status, req: &Request<'_>) -> status::Custom<String> {
    let msg = format!("{} ({})", status, req.uri());
    status::Custom(status, msg)
}

fn rocket() -> Rocket<Build> {
    rocket::build()
        .mount("/", routes![get_trending,get_anime_by_id,get_anime_by_name])
        .register("/", catchers![default_catcher])
}

#[rocket::main]
async fn main() {
    println!("Rocket is launching!");
    if let Err(e) = rocket().launch().await {
        println!("Whoops! Rocket didn't launch!");
        drop(e);
    };
}