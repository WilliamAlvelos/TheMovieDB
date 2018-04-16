# TheMovieDB
a simple application to see some movies. Swift - IOS11

I created this application because I was bored, and I like to spend my free time studing or doing stuffs like this app, I did that using themoviedb api.

I would like to improve this app or do a bigger one but that is all that I can do in my free time.

See more apps as that on my [github profile](https://github.com/WilliamAlvelos).

### API

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/0d9bbc8bf50b9fe53b93)

##### or see some method below

List of genres

```
https://api.themoviedb.org/3/genre/movie/list
```

List of Movies by genre
* This endpoint you must send a genre identifier to receive all movies related with that.

```
https://api.themoviedb.org/3/genre/{genreID}/movies
```

## Deployment

I did that using this pods:
* Alamofire
* AlamofireImage
* XCDYouTubeKit

The architeture that I saw most useful for this project was MVP (Model View Presenter), I chose this because in the future I gonna implement more tests and with this I can manipulate layer by layer.

I might have a coverage near by than 90%

## Acknowledgments

* themoviedb to have this rest api ready for use.
