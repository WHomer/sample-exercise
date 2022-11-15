# README - Song Application

This application takes an artist name as input and outputs to a page songs by that artist.

## Running locally

* Clone this repo
* run `bundle`
* run `rails db:create`
* run `bundle exec figaro install`
* Add the below enviroment variables to application.yml

This application relies on Genius API

``` yml
genius_api_key: <key>
```

## Testing

* Testing can be ran by running `rspec` to run the entire test suite.

## Future and Considerations

These are areas in no particular order that I would look to improve if I was to spend additional time.

* Look at adding type ahead on search input to help the user get to an artist faster.
* Consider caching or storing data to reduce multiple requests.
* Add logic to display `possible_artists` if a match is not exact.
* Add pagination to allow for scrolling past 50 songs.
* Break out controller logic to a seperate service class to remove any logic from controller.
* Further test edge cases on service classes.
