
type Location record {|
    string name;
    string region;
    string country;
    decimal lat;
    decimal lon;
    string tz_id;
    int localtime_epoch;
    string localtime;
    json...;
|};

type Condition record {|
    string text;
    string icon;
    int code;
    json...;
|};

type Current record {|
    int last_updated_epoch;
    string last_updated;
    decimal temp_c;
    decimal temp_f;
    int is_day;
    Condition condition;
    decimal wind_mph;
    int wind_kph;
    int wind_degree;
    string wind_dir;
    int pressure_mb;
    decimal pressure_in;
    decimal precip_mm;
    decimal precip_in;
    int humidity;
    int cloud;
    decimal feelslike_c;
    decimal feelslike_f;
    int windchill_c;
    decimal windchill_f;
    decimal heatindex_c;
    decimal heatindex_f;
    decimal dewpoint_c;
    decimal dewpoint_f;
    int vis_km;
    int vis_miles;
    int uv;
    decimal gust_mph;
    decimal gust_kph;
    json...;
|};

type WeatherDetails record {|
    Location location;
    Current current;
    json...;
|};

type WeatherCondition record {|
    int code;
    string day;
    string night;
    int icon;
    json...;
|};

type External_urls record {|
    string spotify;
    json...;
|};

type ImagesItem record {|
    (int|json)? height;
    string url;
    (int|json)? width;
    json...;
|};

type Owner record {|
    string display_name;
    External_urls external_urls;
    string href;
    string id;
    string 'type;
    string uri;
    json...;
|};

type Tracks record {|
    string href;
    int total;
    json...;
|};

type ItemsItem record {|
    boolean collaborative;
    string description;
    External_urls external_urls;
    string href;
    string id;
    ImagesItem[] images;
    string name;
    Owner owner;
    json primary_color;
    boolean 'public;
    string snapshot_id;
    Tracks tracks;
    string 'type;
    string uri;
    json...;
|};

type Playlists record {|
    string href;
    int 'limit;
    string next;
    int offset;
    json previous;
    int total;
    (ItemsItem|json)[] items;
    json...;
|};

type SpotifySearchResult record {|
    Playlists playlists;
    json...;
|};
