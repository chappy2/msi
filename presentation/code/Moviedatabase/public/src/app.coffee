re = new RegExp(/[ \?]/, 'g');

removeSpace= (input) ->
    input.replace(re, '');

class Film
    # values as object {year:2001,...}
    # Films are stored in localstorage, all functions are only for creation. JSON doesn't provide functions.
    constructor: (values) ->
        success=@setAttributes values
        if success
            @id=removeSpace values.title + values.year
    validate: (values)->
        # TODO
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
    newFilm: (values,callback) ->
        futureId=removeSpace values.title + values.year
        checkExisting=@getFilm(futureId)
        if not checkExisting? or checkExisting.length>=1
            callback?()
            return false
        elem=new Film(values)
        @collection.push elem
        @save(callback)
        true
    removeFilm: (ids,callback) ->
        @collection = (film for film in @collection when film.id != ids)
        @save(callback)
    getFilm:(ids) -> 
        result=(film for film in @collection when film.id == ids)
        result
    getCollection: ->
        @collection
    fetch: (callback)-> 
        temp=localStorage[@storageName]
        # check if empty, otherwise fill one element
        if not temp?
            @collection=[]
            @newFilm {year:2018,title:'le movie',director:'derpington',fsk:'18',runtime:'2011-2015'}
         else 
            @collection=JSON.parse temp
        callback?()
    save: (callback)->
        localStorage[@storageName]=JSON.stringify @getCollection()
        callback?()
    updateFilm: (id,attribut,value) ->
        films=@getFilm id
        films[0].attributes[attribut]=value
        films[0].id=removeSpace films[0].attributes.title+films[0].attributes.year
    sort: (attribut,sorting)->
        @sorted={attribut,sorting}
        asc=(a,b)-> 
            # Example for JavaScript Function Scope (Classes are compiled to Functions in CoffeeScript)
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
        @aSortTitle='#sortTitle'
        @aSortDirector='#sortDirector'
        @aSortFsk='#sortfsk'
        @aSortYear='#sortYear'
        @aSortRuntime='#sortRuntime'
        
        @sorted=["",""]
        @filmList=filmList
        
        # add callback for fetch, an render when done
        # Example no arguments function calls need ()
        @render()
        # Example for fat arrow => binding
        $(@inputFsk).on 'keydown',(event) =>
            #@createOnEnter event
            @showDialogSave( @createOnEnter,event)
        $(@buttonCreate).on 'click',(event) =>
            @showDialogSave( @createFilm,event)
        $(@buttonSave).on 'click',(event) =>
            @saveFilmList(event,@render)
        $(@aSortTitle+","+@aSortDirector+","+@aSortYear+","+@aSortRuntime+","+@aSortFsk).on 'click',(event)=>
            @showDialogSave( @sort,event)
        # jquery ui initialization
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
        # return this
        @
    render: =>
        ###
         render used as callback function (propagated trough FilmList localStorage interactions
        ###
        # Example for Array Comprehension
        trString=(@renderFilm film for film in @filmList.getCollection())
        $(@tbodyData).empty()
        $(@tbodyData).append trString.join()
        @addDeleteEvents()
        @initXEditableFields()
        $( "button" ).button()
        @renderSaveButton()
        @renderSorting()
    renderSorting:  ->
        if @sorted[0] != "" and @sorted[1] != ""
            $(".sort-asc,.sort-desc").each (k, v) =>
                v.setAttribute "class",""
                v.lastChild.setAttribute "class",""
            # mark link as sorted
            $(@sorted[0]).attr "class",@sorted[1]
            # insert icon in a>span
            iconClass="ui-icon ui-icon-caret-1-"
            if @sorted[1] is "sort-asc"
                iconClass=iconClass+"s"
            else
                iconClass=iconClass+"n"
            $(@sorted[0]+">span").attr "class",iconClass
    renderSaveButton: ->
        $('.editable').on 'click',(event) =>
            $('div').on 'save',(event) =>
                $(@buttonSave).button("enable")
            $(@buttonSave).button("disable")
    renderFilm: (film)->
        values= film.attributes
        # Example for String Interpolation with #{} and multiline String definition
        """<tr id='#{film.id}_row'>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_title">#{values.title}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_director">#{values.director}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_year">#{values.year}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"  data-title="Enter username" id="#{film.id}_runtime">#{values.runtime}</a></td>
            <td><a href="#" data-type="text"  data-pk="#{film.id}"   data-title="Enter username" id="#{film.id}_fsk">#{values.fsk}</a></td>
            <td><form>
                <button  id='#{film.id}'  class='ui-button ui-corner-all ui-widget ui-button-icon-only ' >
                    <span class="ui-icon ui-icon-minus"></span>
                </button>
            </form></td>
        </tr>"""
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
                @deleteFilm event,@render 
        
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
    createFilm: (event,callback) ->
        values=@readInputFields()
        valid=@checkInputFields values
        if  valid
            created=@filmList.newFilm values,callback
            if not created
                $("#dialog-already-exist").dialog("open")
        else
            $("#dialog-invalid-input").dialog("open")
        @
    createOnEnter:(event,callback) ->
        if event.keyCode == 13
            @createFilm(event,callback)
    deleteFilm:(event,callback) ->
        @filmList.removeFilm event.currentTarget.id,callback
        @
    saveFilmList: (event,callback)->
        $(@classNotSaved).each (k, v) =>
            newV=v.id.split "_"
            @filmList.updateFilm newV[0],newV[1],v.innerText
        @filmList.save(callback)
        @
    sort: (event,callback) ->
        sorting="asc"
        # Get attribut name to sort after from a id
        val=event.currentTarget.id.replace "sort",""
        val=val.toLowerCase()
        # check if this attribut has been sorted before
        if @sorted[0] is '#'+event.currentTarget.id
            if @sorted[1] is "sort-"+sorting
                sorting="desc"
        # sort collection, keep sorting information and render
        @filmList.sort val,sorting
        @sorted=['#'+event.currentTarget.id,"sort-"+sorting]
        callback?()
        @
    isDataSaved:->
        $('.editable-unsaved').length <= 0
    showDialogSave: (@arg,event) ->
        if not @isDataSaved()
            dynamicButton= {
                "Save and continue":  => 
                    @saveFilmList(event,@render)
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
            
filmList=new FilmList()
app=new FilmListView(filmList)

