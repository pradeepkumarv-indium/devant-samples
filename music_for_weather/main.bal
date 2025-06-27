import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /MusicMood on httpDefaultListener {
    resource function get playList(string location) returns error|json|http:InternalServerError {
        do {
            WeatherDetails currentWeather = check weatherApiHttpClient->get(string `/current.json?key=${WEATHER_COM_API_KEY}&q=${location}`);
            log:printInfo(currentWeather.toString());
            int currentWeatherCode = currentWeather.current.condition.code;
            string currentWeatherType = "";
            WeatherCondition[] weatherConditions = check weatherConditionHttpClient->get("/docs/weather_conditions.json");
            log:printInfo(weatherConditions.toString());           
            foreach WeatherCondition weatherCondition in weatherConditions {
                if(currentWeatherCode == weatherCondition.code){
                    currentWeatherType = weatherCondition.day;
                }              
            }


        SpotifySearchResult searchResults  = check spotifyHttpClient->get(string `/search?q=${currentWeatherType}&type=playlist`);
        log:printInfo(searchResults.toString());

        var playlist = from var item in searchResults.playlists.items
        where item is ItemsItem
        select {
            name: item.name,
            URL: item.external_urls.spotify,
            artist: item.owner.display_name
        };

        json musicMood = {
            city: location,
            weather: currentWeatherType,
            playlist: playlist
        };
        log:printInfo(musicMood.toString());

        return musicMood;


        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
