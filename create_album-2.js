var Promise = require('bluebird');
var prompt = require('prompt-promise');
var pgp = require('pg-promise')({
  promiseLib: Promise
});




prompt('album name?')
  .then(function(album_name) {
    return [album_name, prompt('Album year? ')];
  })
  .spread(function(album_name, album_year) {
    return [album_name, album_year, prompt('Artist id?')];
  })
  .spread(function (album_name, album_year, artist_id) {
    var sql ='insert into album values ' +
    "(default, '" + album_name + "', " + artist_id + ", " + album_year + ")";
    console.log('SQL: ' + sql);
    return db.none(sql);
  })

  .then(function() {
    console.log("It worked!");
    pgp.end();
  })
  .catch(function(err) {
    console.log(err.message);
  });
