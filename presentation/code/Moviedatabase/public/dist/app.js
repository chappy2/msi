// Generated by CoffeeScript 1.9.3

/*
Client app Moviedatabase
Collection: gets Data from Server (sqllite database)
functions:
    - create
    - update
    - delete
Model:
    - instance of collection
        - validate
        - create
        - destroy
 */
var Film, FilmList, FilmListView, app, dialogOptions, filmList;

Film = (function() {
  function Film(values) {
    var success, temp;
    success = this.setAttributes(values);
    if (success) {
      temp = values.title + values.year;
      this.id = temp.replace(" ", "");
    }
  }

  Film.prototype.validate = function(values) {
    return true;
  };

  Film.prototype.setAttributes = function(values) {
    if (this.validate(values)) {
      this.attributes = values;
      return true;
    }
    return false;
  };

  Film.prototype.getAttributes = function() {
    return this.attributes;
  };

  return Film;

})();

FilmList = (function() {
  function FilmList() {
    this.storageName = 'demoMoviedatabaseCollection';
    this.fetch();
    this;
  }

  FilmList.prototype.newFilm = function(values) {
    var checkExisting, elem, futureId;
    futureId = values.title + values.year;
    checkExisting = this.getFilm(futureId);
    if ((checkExisting == null) || checkExisting.length >= 1) {
      return false;
    }
    elem = new Film(values);
    this.collection.push(elem);
    this.save();
    return true;
  };

  FilmList.prototype.removeFilm = function(ids) {
    var film;
    this.collection = (function() {
      var i, len, ref, results;
      ref = this.collection;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        film = ref[i];
        if (film.id === ids) {
          results.push(film);
        }
      }
      return results;
    }).call(this);
    return this.save();
  };

  FilmList.prototype.getFilm = function(ids) {
    var film, result;
    result = (function() {
      var i, len, ref, results;
      ref = this.collection;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        film = ref[i];
        if (film.id === ids) {
          results.push(film);
        }
      }
      return results;
    }).call(this);
    return result;
  };

  FilmList.prototype.getCollection = function() {
    return this.collection;
  };

  FilmList.prototype.fetch = function() {
    var temp;
    temp = localStorage[this.storageName];
    if (temp == null) {
      console.log('no data in storage');
      this.collection = [];
      return this.newFilm({
        year: 2018,
        title: 'le movie',
        director: 'derpington',
        fsk: '18',
        runtime: '2011-2015'
      });
    } else {
      return this.collection = JSON.parse(temp);
    }
  };

  FilmList.prototype.save = function() {
    return localStorage[this.storageName] = JSON.stringify(this.getCollection());
  };

  return FilmList;

})();

FilmListView = (function() {
  function FilmListView(filmList) {
    this.inputDirector = '#director';
    this.inputFsk = '#fsk';
    this.inputTitle = '#title';
    this.inputYear = '#year';
    this.inputRuntime = '#runtime';
    this.tbodyData = '#contentData';
    this.filmList = filmList;
    this.render();
    $(this.inputFsk).on('keydown', (function(_this) {
      return function(event) {
        return _this.createOnEnter(event);
      };
    })(this));
    this;
  }

  FilmListView.prototype.render = function() {
    var film, trString;
    trString = (function() {
      var i, len, ref, results;
      ref = this.filmList.getCollection();
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        film = ref[i];
        results.push(this.renderFilm(film));
      }
      return results;
    }).call(this);
    $(this.tbodyData).empty();
    $(this.tbodyData).append(trString.join());
    this.addDeleteEvents();
    return this;
  };

  FilmListView.prototype.renderFilm = function(film) {
    var values;
    values = film.attributes;
    return "<tr id='" + film.id + "_row'><td>" + values.title + "</td><td>" + values.director + "</td><td>" + values.year + "</td><td>" + values.runtime + "</td><td>" + values.fsk + "</td><td><form><input type='button' id='" + film.id + "'  class='' /></form></td><tr>";
  };

  FilmListView.prototype.addDeleteEvents = function() {
    var film, i, len, ref, results;
    ref = this.filmList.getCollection();
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      film = ref[i];
      results.push($("#" + film.id).on('click', (function(_this) {
        return function(event) {
          return _this.deleteFilm(event);
        };
      })(this)));
    }
    return results;
  };

  FilmListView.prototype.checkInputFields = function(values) {
    var isNotEmpty, k, v;
    isNotEmpty = true;
    for (k in values) {
      v = values[k];
      if (!v) {
        isNotEmpty = false;
      }
    }
    return isNotEmpty;
  };

  FilmListView.prototype.readInputFields = function() {
    var values;
    values = {};
    values.title = $(this.inputTitle).val();
    values.director = $(this.inputDirector).val();
    values.year = $(this.inputYear).val();
    values.runtime = $(this.inputRuntime).val();
    values.fsk = $(this.inputFsk).val();
    return values;
  };

  FilmListView.prototype.createOnEnter = function(event) {
    var created, valid, values;
    if (event.keyCode === 13) {
      values = this.readInputFields();
      valid = this.checkInputFields(values);
      if (valid) {
        created = this.filmList.newFilm(values);
        if (!created) {
          return $("#dialog-already-exist").dialog("open");
        } else {
          return this.render();
        }
      } else {
        return $("#dialog-invalid-input").dialog("open");
      }
    }
  };

  FilmListView.prototype.deleteFilm = function(event) {
    this.filmList.removeFilm(event.currentTarget.id);
    return $("#" + event.currentTarget.id + "_row").remove();
  };

  FilmListView.prototype.selectFilmForEdit = function(event) {
    return true;
  };

  FilmListView.prototype.updateFilm = function(event) {
    return true;
  };

  FilmListView.prototype.sort = function() {
    return true;
  };

  return FilmListView;

})();

filmList = new FilmList();

app = new FilmListView(filmList);

app.render();

dialogOptions = {
  autoOpen: false,
  show: "blind",
  hide: "blind",
  modal: true
};

$("#dialog-invalid-input").dialog(dialogOptions);

$("#dialog-already-exist").dialog(dialogOptions);
