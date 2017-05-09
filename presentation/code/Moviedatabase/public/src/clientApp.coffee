# ## *removeCharacters*#
# Function in this App Scope (not global, CoffeeScript compiles the application within a JavaScript function scope).
#
# Removes unwanted Characters in html id names.
re = new RegExp /[ \?]/g
removeCharacters= (input) ->
    console.log """ 
                Leerzeichen und Fragezeichen 
                werden aus #{input} entfernt.
                """
    input.replace re, ''
    
# ## Class *View*#
# Base View for *MovieListView*.
# #### log
# short function for logging values
# parameter <i>value</i> needed
# #### render
# only logs for demonstrations purpose (parent logging in MovieListView)
class View
    render: ->
       @.log "View render called class View"

    log: (value) ->
        console.log value
        
# ## Class *Movie*
# parameter values always as object {year:2001,...}
#
# Movies are stored in localstorage (as JSON String) in MovieList. All functions are only for creation. JSON doesn't provide functions.
# Functions are only implemented to garantee the same structure of Movieobjects.
class Movie
    constructor: (values) ->
        success=@setAttributes values
        if success
            @id=removeCharacters values.title + values.year
    validate: (values)->
        true
    setAttributes: (values) ->
        if @validate values
            @attributes=values
            return true
        return false
        
# ## Class *MovieList*
# *MovieList* uses Localstorage. Complete Collection is loaded into localstorage.
# #### constructor
# - constructor can be defined for classes
# - function calls without arguments needs () 
#
# #### newMovie
# - generates Id for the new movie from given values
# - adds movie to collection and saves it
# - return true or false if successful (return can be used in CoffeeScript)
#
# #### removeMovie
# - deletes the movie via comprehension
# - All movies remain in collection if id is not the same as the given id
#
# #### updateMovie
# Another example for comprehension. This time it returns the one movie with the same *id* (parameter).
# #### fetch
# Example for ? operator.
# #### sort
# Example for JavaScript Function Scope (classes are compiled to functions in CoffeeScript).
class MovieList
    constructor: ->
        @storageName='demomoviesdatabaseCollection'
        @fetch()
        @
    newMovie: (values,callback) ->
        futureId=removeCharacters values.title + values.year
        checkExisting=@getMovie(futureId)
        if not checkExisting? or checkExisting.length>=1
            callback?()
            return false
        elem=new Movie(values)
        @collection.push elem
        @save(callback)
        true
    removeMovie: (ids,callback) ->
        @collection = (movie for movie in @collection when movie.id != ids)
        @save(callback)
    getMovie:(ids) -> 
        result=(movie for movie in @collection when movie.id == ids)
        result
    getCollection: ->
        @collection
    fetch: (callback)-> 
        temp=localStorage[@storageName]
        if not temp?
            @collection=[]
            @newMovie {year:2018,title:'le movies',director:'derpington',fsk:'18',runtime:'2011-2015'}
         else 
            @collection=JSON.parse temp
        callback?()
    save: (callback)->
        localStorage[@storageName]=JSON.stringify @getCollection()
        callback?()
    updateMovie: (id,attribut,value) ->
        movies=@getMovie id
        movies[0].attributes[attribut]=value
        movies[0].id=removeCharacters movies[0].attributes.title+movies[0].attributes.year
    sort: (attribut,sorting)->
        @sorted={attribut,sorting}
        asc=(a,b)-> 
            if a.attributes[attribut] < b.attributes[attribut] 
                return -1
            if a.attributes[attribut]  > b.attributes[attribut] 
                return 1
            0
        desc=(a,b)-> 
            if a.attributes[attribut] > b.attributes[attribut] 
                return -1
            if a.attributes[attribut]  < b.attributes[attribut] 
                return 1
            0
        if sorting is "asc"
            @collection=@collection.sort(asc)
        else
            @collection=@collection.sort(desc)
# ## Class *MovieList*
# *MovieList* uses localstorage. Complete Collection is loaded and storedi into localstorage.
# #### constructor
# - DOM Ids and classes
# - state (sorting)
# - add callback for *fetch*, and *render* when done
# - Example for fat arrow => binding
#
# #### render
# - *render* used as callback function (called after *MovieList* localStorage interactions)
# - it overrides the *render* function of the super class *View*
# - Example for Array Comprehension. For each item in collection the function *renderMovie* is called
# - Example of use of super class *View* function *log*
#
# #### renderSorting
# render the sorting icons
# #### renderMovie
# Example for String Interpolation with #{} and multiline String definition
# #### initXEditableFields
# init jquery ui editable fields
# #### addDeleteEvents
# Example for in Loop (over arrays)
# #### checkInputFields
# - Example of for loop over Object
# - Example for checking empty string
# 
# #### readInputFields
# Example Javascript Ex Nilho Object Creation
# #### createMovie
# check input and create
# #### createOnEnter
# creation of a movie after pressing enter on fsk input field
# #### deleteMovie
# ...
# #### saveMovieList
# - id of eidtable data is movie.id_attributKey, value is innerText of v
# - eg <a id="exampleId1997_director" ...>the edited value</a>
#
# #### sort
# - Get attribut name to sort after a id
# - check if this attribut has been sorted before
# - sort collection, keep sorting information and *render*
# - callback invoked here. No localStorage interaktion. Parameter needed, otherwise showDialogSave can't call this function.
#
# #### isDataSaved
# ...
# #### showDialogSave
# unsaved changes to movies will be lost after creating new movies ort sort the collection. this dialog ask if edited values should be saved. @arg is @saveMovieList or @sort.
#      
class MovieListView extends View
    constructor: (MovieList)->
        @inputDirector='#director'
        @inputFsk= '#fsk'
        @inputTitle='#title'
        @inputYear='#year'
        @inputRuntime='#runtime'
        @tbodyData= '#contentData'
        @buttonSave='#save-table'
        @buttonCreate='#create-movie'
        @classNotSaved='.editable-unsaved'
        @aSortTitle='#sortTitle'
        @aSortDirector='#sortDirector'
        @aSortFsk='#sortfsk'
        @aSortYear='#sortYear'
        @aSortRuntime='#sortRuntime'
       
        @sorted=["",""]
        @MovieList=MovieList
        
        
        @render()
        
        $(@inputFsk).on 'keydown',(event) =>
            if event.keyCode == 13
                @showDialogSave( @createMovie,event)
        $(@buttonCreate).on 'click',(event) =>
            @showDialogSave( @createMovie,event)
        $(@buttonSave).on 'click',(event) =>
            @saveMovieList(event,@render)
        $(@aSortTitle+","+@aSortDirector+","+@aSortYear+","+@aSortRuntime+","+@aSortFsk).on 'click',(event)=>
            @showDialogSave( @sort,event)
    
        dialogOptions={
            autoOpen:false,
            show:"blind",
            hide:"blind", 
            modal: true
        }
        $("#dialog-invalid-input").dialog dialogOptions
        $("#dialog-already-exist").dialog dialogOptions
        $("#dialog-eidtable-not-saved").dialog dialogOptions

        $.fn.editable.defaults.mode = 'inline'
        @
    render: =>
        @log "render fired"
        trString=(@renderMovie movie for movie in @MovieList.getCollection())
        $(@tbodyData).empty()
        $(@tbodyData).append trString.join()
        @addDeleteEvents()
        @initXEditableFields()
        $( "button" ).button()
        @renderSorting()
    renderSorting:  ->
        if @sorted[0] != "" and @sorted[1] != ""
            $(".sort-asc,.sort-desc").each (k, v) =>
                v.setAttribute "class",""
                v.lastChild.setAttribute "class",""
            $(@sorted[0]).attr "class",@sorted[1]
            iconClass="ui-icon ui-icon-caret-1-"
            if @sorted[1] is "sort-asc"
                iconClass=iconClass+"s"
            else
                iconClass=iconClass+"n"
            $(@sorted[0]+">span").attr "class",iconClass
    renderMovie: (movie)->
        values= movie.attributes
        """<tr id='#{movie.id}_row'>
            <td><a href="#" data-type="text"  data-pk="#{movie.id}"  data-title="Enter username" id="#{movie.id}_title">#{values.title}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{movie.id}"  data-title="Enter username" id="#{movie.id}_director">#{values.director}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{movie.id}"  data-title="Enter username" id="#{movie.id}_year">#{values.year}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{movie.id}"  data-title="Enter username" id="#{movie.id}_runtime">#{values.runtime}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{movie.id}"   data-title="Enter username" id="#{movie.id}_fsk">#{values.fsk}</a></td>
            <td><form>
                <button  id='#{movie.id}'  class='ui-button ui-corner-all ui-widget ui-button-icon-only ' >
                    <span class="ui-icon ui-icon-minus"></span>
                </button>
            </form></td>
        </tr>"""
    initXEditableFields: ->
        $.fn.editable.defaults.mode = 'inline'
        for movie in @MovieList.getCollection()
            $("#"+movie.id+"_title").editable()
            $("#"+movie.id+"_director").editable()
            $("#"+movie.id+"_year").editable()
            $("#"+movie.id+"_runtime").editable()
            $("#"+movie.id+"_fsk").editable()
    addDeleteEvents:  ->
        for movie in @MovieList.getCollection()
            $("#"+movie.id).on 'click',(event) =>
                @deleteMovie event,@render 
        
    checkInputFields: (values)->
        isNotEmpty=true
        for k,v of values
           if not v
                isNotEmpty=false
        isNotEmpty
    readInputFields: ->
        values={}
        values.title =$(@inputTitle).val()
        values.director =$(@inputDirector).val()
        values.year =$(@inputYear).val()
        values.runtime =$(@inputRuntime).val()
        values.fsk =$(@inputFsk).val()
        values
    createMovie: (event,callback) ->
        values=@readInputFields()
        valid=@checkInputFields values
        if  valid
            created=@MovieList.newMovie values,callback
            if not created
                $("#dialog-already-exist").dialog("open")
        else
            $("#dialog-invalid-input").dialog("open")
        @
    deleteMovie:(event,callback) ->
        @MovieList.removeMovie event.currentTarget.id,callback
        @
    saveMovieList: (event,callback)->
        $(@classNotSaved).each (k, v) =>
            newV=v.id.split "_"
            @MovieList.updateMovie newV[0],newV[1],v.innerHTML
        @MovieList.save(callback)
        @
    sort: (event,callback) ->
        sorting="asc"
        val=event.currentTarget.id.replace "sort",""
        val=val.toLowerCase()
        if @sorted[0] is '#'+event.currentTarget.id
            if @sorted[1] is "sort-"+sorting
                sorting="desc"
        @MovieList.sort val,sorting
        @sorted=['#'+event.currentTarget.id,"sort-"+sorting]
        callback?()
        @
    isDataSaved:->
        $('.editable-unsaved').length <= 0
    showDialogSave: (@arg,event) ->
        if not @isDataSaved()
            dynamicButton= {
                "Save and continue":  => 
                    @saveMovieList(event) 
                    @arg(event,@render)
                    $("#dialog-eidtable-not-saved").dialog "close"         ,
                "No Save and continue":  => 
                    @arg(event,@render)
                    $("#dialog-eidtable-not-saved").dialog "close"  
            }
            $("#dialog-eidtable-not-saved").dialog "option","buttons",dynamicButton
            $("#dialog-eidtable-not-saved").dialog "open"
        else
            @arg(event,@render)
# Init the app            
MovieList=new MovieList()
app=new MovieListView(MovieList)

