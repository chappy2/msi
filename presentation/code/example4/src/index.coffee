class View
    render : ->
        @.log "View render called class View"
    log: (value) ->
        console.log value
class FilmListView extends View
    render : ->
        @.log "FilmListView render called"
        
filmListView=new FilmListView()
filmListView.render()
filmListView.log filmListView.__proto__