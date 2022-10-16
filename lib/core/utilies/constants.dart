class AppConstants{
  static const baseUrl = "https://api.themoviedb.org/3";
  static const apiKey = "e316bcaf226f51b98ceda8b9fd897cfe";
  static const nowPlayingPath = "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const popularPlayingPath = "$baseUrl/movie/popular?api_key=$apiKey";
  static const getTopRatedMoviePath = "$baseUrl/movie//top_rated?api_key=$apiKey";
}