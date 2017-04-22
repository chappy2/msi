###
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
        ###

class Film
    # values as object {year:2001,...}
    constructor: (values) ->
        success=@setAttributes values
        if success
            temp=values.title + values.year
            @id=temp.replace " ",""
    validate: (values)->
        # if true then set attributes
        true
    setAttributes: (values) ->
        if @validate values
            console.log values.title
            @attributes=values
            return true
        return false
    getAttributes: ->
        return @attributes
# Film List uses Localstorage. Complete Colleciton is loaded into localstorage
class FilmList
    # add sorting stuff
    constructor: ->
        @storageName='demoMoviedatabaseCollection'
        @fetch()
        @
    newFilm: (values) ->
        console.log "new film"
        elem=new Film(values)
        #only push if valid
        @collection.push elem
        @save()
    removeFilm: (ids) ->
        console.log ids
        @collection = (film for film in @collection when film.id == ids)
        @save()
    getFilm:(ids) -> 
        @collection.filter (obj) ->
            obj.id=ids
    getCollection: ->
        @collection
    # route noch nicht da
    fetch: -> 
        temp=localStorage[@storageName]
        # check if empty, otherwise fill one element
        if not temp?
            console.log 'no data in storage'
            @collection=[]
            @newFilm {year:2018,title:'le movie',director:'derpington',fsk:'18',runtime:'2011-2015'}
        else 
            @collection=JSON.parse temp
    save: ->
        localStorage[@storageName]=JSON.stringify @getCollection()
    
        



class FilmListView
    constructor: (filmList)->
        @inputDirector='#director'
        @inputFsk= '#fsk'
        @inputTitle='#title'
        @inputYear='#year'
        @inputRuntime='#runtime'
        @tbodyData= '#contentData'
        
        @filmList=filmList
        @filmList.fetch()
        
        console.log 'done fetching'
        # add callback for fetch, an render when done
        # Example no arguments function calls need ()
        @render()
        # Example for fat arrow => binding
        $(@inputFsk).on 'keydown',(event) =>
            console.log 'enterd something'
            @createOnEnter event
        # return this
        console.log @inputFsk
        @
    render: ->
        # Example for Array Comprehension
        trString=(@renderFilm film for film in @filmList.getCollection())
        $(@tbodyData).empty()
        $(@tbodyData).append trString.join()
        @addDeleteEvents()
        @
    renderFilm: (film)->
        values= film.attributes
        # Example for String Interpolation with #{}
        "<tr id='#{film.id}_row'><td>#{values.title}</td><td>#{values.director}</td><td>#{values.year}</td><td>#{values.runtime}</td><td>#{values.fsk}</td><td><form><input type='button' id='#{film.id}'  class='' /></form></td><tr>"
    # events
    addDeleteEvents:  ->
        # Example for in Loop (over arrays)
        for film in @filmList.getCollection()
            $("#"+film.id).on 'click',(event) =>
                @deleteFilm event
    checkInputFields: (values)->
        isNotEmpty=true
        # Example of for loop over Object
        for k,v of values
            # Example for checking empty string
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
    createOnEnter:(event) ->
        if event.keyCode == 13
            values=@readInputFields()
            valid=@checkInputFields values
            if  valid
                @filmList.newFilm values
                @render()
            else
                $("#dialog-invalid-input").dialog("open")
    deleteFilm:(event) ->
        console.log event
        console.log "deleting"+event.currentTarget.id
        @filmList.removeFilm event.currentTarget.id
        $("#"+event.currentTarget.id+"_row").remove()
    selectFilmForEdit: (event)->
        true
    updateFilm: (event)->
        true
    sort: ->
        true



filmList=new FilmList()
app=new FilmListView(filmList)
app.render()
# init jquery ui stuff..
# todo refactor this
dialogOptions={
    autoOpen:false,
    show:"blind",
    hide:"blind", 
    modal: true
}
$("#dialog-invalid-input").dialog dialogOptions
#$("#contentData").selectable()