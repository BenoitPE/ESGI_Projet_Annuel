FROM rust:latest as builder
WORKDIR /app
COPY . .
RUN cargo build --release


FROM rust:slim-buster as runner
WORKDIR /app
COPY --from=builder /app/queries/ ./queries
COPY --from=builder /app/target/release/AnimeApi .
ENV ROCKET_ADDRESS=0.0.0.0
EXPOSE 8000
CMD ["/app/AnimeApi"]
