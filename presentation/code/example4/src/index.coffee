class View
    render : ->
        @.log "View render called class View"
    log: (value) ->
        console.log value
class MovieListView extends View
    render : ->
        @.log "MovieListView render called"
        
movieListView=new MovieListView()
movieListView.render()
movieListView.log movieListView.__proto__
