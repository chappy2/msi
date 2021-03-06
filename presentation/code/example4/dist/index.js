// Generated by CoffeeScript 1.9.3
(function() {
  var FilmListView, View, filmListView,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  View = (function() {
    function View() {}

    View.prototype.render = function() {
      return this.log("View render called class View");
    };

    View.prototype.log = function(value) {
      return console.log(value);
    };

    return View;

  })();

  FilmListView = (function(superClass) {
    extend(FilmListView, superClass);

    function FilmListView() {
      return FilmListView.__super__.constructor.apply(this, arguments);
    }

    FilmListView.prototype.render = function() {
      return this.log("FilmListView render called");
    };

    return FilmListView;

  })(View);

  filmListView = new FilmListView();

  filmListView.render();

  filmListView.log(filmListView.__proto__);

}).call(this);
