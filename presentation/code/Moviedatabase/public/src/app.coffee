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
removeSpace= (input) ->
    input.replace " ",""

class Film
    # values as object {year:2001,...}
    # Films are stored in localstorage, all functions are only for creation. JSON doesn't provide functions.
    constructor: (values) ->
        success=@setAttributes values
        if success
            @id=removeSpace values.title + values.year
    validate: (values)->
        # if true then set attributes
        true
    setAttributes: (values) ->
        if @validate values
            @attributes=values
            return true
        return false
# Film List uses Localstorage. Complete Colleciton is loaded into localstorage
class FilmList
    # add sorting stuff
    constructor: ->
        @storageName='demoMoviedatabaseCollection'
        @fetch()
        @
    newFilm: (values) ->
        futureId=removeSpace values.title + values.year
        checkExisting=@getFilm(futureId)
        if not checkExisting? or checkExisting.length>=1
            return false
        elem=new Film(values)
        @collection.push elem
        @save()
        true
    removeFilm: (ids) ->
        @collection = (film for film in @collection when film.id != ids)
        @save()
    getFilm:(ids) -> 
        result=(film for film in @collection when film.id == ids)
        result
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
    updateFilm: (id,attribut,value) ->
        films=@getFilm id
        films[0].attributes[attribut]=value
        films[0].id=removeSpace films[0].attributes.title+films[0].attributes.year

class FilmListView
    constructor: (filmList)->
        @inputDirector='#director'
        @inputFsk= '#fsk'
        @inputTitle='#title'
        @inputYear='#year'
        @inputRuntime='#runtime'
        @tbodyData= '#contentData'
        @buttonSave='#save-table'
        @buttonCreate='#create-film'
        @classNotSaved='.editable-unsaved'
        
        @filmList=filmList
        
        # add callback for fetch, an render when done
        # Example no arguments function calls need ()
        @render()
        # Example for fat arrow => binding
        $(@inputFsk).on 'keydown',(event) =>
            @createOnEnter event
        $(@buttonCreate).on 'click',(event) =>
            console.log "fired"
            @createFilm event
        $(@buttonSave).on 'click',(event) =>
            @saveFilmList event
       
        # return this
        @
    findEventOnChangeEditable: -> 
        $('edit').on 'save',(event) =>
            console.log event
    render: ->
        # Example for Array Comprehension
        trString=(@renderFilm film for film in @filmList.getCollection())
        $(@tbodyData).empty()
        $(@tbodyData).append trString.join()
        @addDeleteEvents()
        @initXEditableFields()
        $( "button" ).button();
        
        $('.editable').on 'click',(event) =>
            console.log event
            $('div').on 'save',(event) =>
                $(@buttonSave).button("enable")
        $(@buttonSave).button("disable")      
        @
    renderFilm: (film)->
        values= film.attributes
        # Example for String Interpolation with #{}
        """<tr id='#{film.id}_row'>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_title">#{values.title}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_director">#{values.director}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_year">#{values.year}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_runtime">#{values.runtime}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"   data-title="Enter username" id="#{film.id}_fsk">#{values.fsk}</a></td>
            <td><form><button  id='#{film.id}'  class='ui-button ui-corner-all ui-widget ui-button-icon-only ' ><span class="ui-icon ui-icon-minus"></span></button></form></td><tr>"""
    initXEditableFields: ->
        $.fn.editable.defaults.mode = 'inline'
        for film in @filmList.getCollection()
            $("#"+film.id+"_title").editable()
            $("#"+film.id+"_director").editable()
            $("#"+film.id+"_year").editable()
            $("#"+film.id+"_runtime").editable()
            $("#"+film.id+"_fsk").editable()
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
    createFilm: (event) ->
        values=@readInputFields()
        valid=@checkInputFields values
        if  valid
            created=@filmList.newFilm values
            if not created
                $("#dialog-already-exist").dialog("open")
            else
                @render()
        else
            $("#dialog-invalid-input").dialog("open")
    createOnEnter:(event) ->
        if event.keyCode == 13
            @createFilm()
    deleteFilm:(event) ->
        @filmList.removeFilm event.currentTarget.id
        $("#"+event.currentTarget.id+"_row").remove()
    saveFilmList: (event)->
        $(@classNotSaved).each (k, v) =>
            newV=v.id.split "_"
            @filmList.updateFilm newV[0],newV[1],v.innerText
        @filmList.save()
        @render()
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
$("#dialog-already-exist").dialog dialogOptions


$.fn.editable.defaults.mode = 'inline'
#$("#contentData").selectable()