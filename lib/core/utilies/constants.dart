class AppConstants{
  ///Movie Module
  static const baseUrl = "https://api.themoviedb.org/3";
  static const apiKey = "e316bcaf226f51b98ceda8b9fd897cfe";
  static const nowPlayingPath = "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const popularPlayingPath = "$baseUrl/movie/popular?api_key=$apiKey";
  static const getTopRatedMoviePath = "$baseUrl/movie/top_rated?api_key=$apiKey";
  static const getUpComingMoviePath = "$baseUrl/movie/upcoming?api_key=$apiKey";
  static  getMovieDetailsPath(int movieId) => "$baseUrl/movie/$movieId?api_key=$apiKey";
  static String movieCast(int movieId) =>
      '$baseUrl/movie/$movieId/credits?api_key=$apiKey';
  static  getMovieRecommendationPath(int movieId) => "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";
  static const baseImageUrl = "https://image.tmdb.org/t/p/original";
  static String imageUrl(String path)=> '$baseImageUrl$path';

  ///Tv Module

}