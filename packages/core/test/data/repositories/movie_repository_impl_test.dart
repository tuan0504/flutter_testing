import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movies/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });
  
  const tMovieModel = MovieModel(
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

  const tMovie = Movie(
    adult: false,
    backdropPath: null,
    genreIds: [],
    id: 481699,
    originalTitle: 'Testing',
    overview: 'A disembodied voice struggles to make ethical judgements about a sinister experiment.',
    popularity: 0.292,
    posterPath: '/gNauEV30KDkYPghpeypdGjPF9Wm.jpg',
    releaseDate: "",
    title: 'Testing',
    video: false,
    voteAverage: 0,
    voteCount: 0,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      final resultList = result.getOrElse(() => []);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return common failure when the call to remote data source is certificate verify failed',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenThrow(const TlsException());
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result,
          equals(const Left(CommonFailure('Certificated Not Valid:\n'))));
    });
  });
}
