import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';

const testMovie = Movie(
  adult: false,
  backdropPath: null,
  genreIds: [35],
  id: 1076038,
  originalTitle: 'Testing',
  overview:'When a young gay man suspects he has an STI and goes in for testing, he discovers the older man he recently slept with is a doctor at the clinic.',
  popularity: 1.149,
  posterPath: '/xqZp0A1FSlosBWLRcxyP0y1MnDP.jpg',
  releaseDate: '2022-11-17',
  title: 'Testing',
  video: false,
  voteAverage: 0,
  voteCount: 0,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
