removeCharacters= (input) ->
    re = new RegExp /[ \?]/g
    console.log """ 
                Leerzeichen und Fragezeichen 
                werden aus #{input} entfernt.
                """
    input.replace re,''
console.log removeCharacters "Hallo Welt?"