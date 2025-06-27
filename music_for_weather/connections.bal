import ballerina/http;

final http:Client weatherApiHttpClient = check new ("https://api.weatherapi.com/v1");
final http:Client weatherConditionHttpClient = check new ("https://www.weatherapi.com");
final http:Client spotifyHttpClient = check new ("https://api.spotify.com/v1", auth = {
    tokenUrl: "https://accounts.spotify.com/api/token",
    clientId: SPOTIFY_CLIENT_ID,
    clientSecret: SPOTIFY_CLIENT_SECRET
});
