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
    @attributes: {}
    # values as object {year:2001,...}
    constructor: (values) ->
        @setAttributes values
        
    validate: (values)->
        # if true then set attributes
        true
    setAttributes: (values) ->
        if @validate values
            console.log values.title
            @attributes=values
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
    getFilm: -> 
        false
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
        # add all events to dom!
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
    renderFilm: (film)->
        values= film.attributes
        # Example for String Interpolation with #{}
        "<tr><td>#{values.title}</td><td>#{values.director}</td><td>#{values.year}</td><td>#{values.runtime}</td><td>#{values.fsk}</td><td><a class='ui-state-default ui-corner-all'><span class='ui-icon ui-icon-trash'></span></a></td><tr>"
    # events
    
    checkInputFields: (values)->
        isEmpty=(true for field in values when field isnt '')
        console.log isEmpty
        isEmpty
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
            if @checkInputFields(values)
                @filmList.newFilm(values)
                @render()
    deleteFilm:(event) ->
        true
    selectFilmForEdit: (event)->
        true
    updateFilm: (event)->
        true
    sort: ->
        true



filmList=new FilmList()
app=new FilmListView(filmList)
app.render()
