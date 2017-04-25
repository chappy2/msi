# msi
Assignment for MSI. Presentation made with [reveal.js](http://lab.hakim.se/reveal-js/#/) and a Plugin to [run commands in terminal](https://github.com/dluxemburg/reveal-run-in-terminal).

## Installation
### Konfiguration
Datei *msi/presentation/config/defaultExample.json* kopieren und umbenennen in *default.json*. Je nach Umgebung die Werte anpassen.

### Abhängigkeiten ohne npm
Zusätzlich benötigt jeweils im Ordner msi git clone:


Reveal js Plugin:
```
git clone https://github.com/dluxemburg/reveal-run-in-terminal
```
Reveal js:
```
git clone https://github.com/hakimel/reveal.js
```
### Server Installation
#### Coffee Script
Unter Ubuntu ging das npm package coffee-scirpt nicht. Habe es temporär ohne npm installiert:

```
sudo apt-get install coffeescript
```

#### Nodejs und Dependencies
Node js: https://nodejs.org/en/download/package-manager/
node js mit nvm installieren. 
```
nvm install v4.6.2
```
nvm Version _v4.6.2_ benutzen.

Im ordner *msi/presentation* und *reveal-run-in-terminal* und *msi/presentation/code/Moviedatabase*
```
npm install
```

Präsentation dann starten mit im *presentation* Ordner
```
node app.js
```
Demo starten mit im *presentation/code/Moviedatabase* Ordner
```
node ./dist/app.js
```
Je nach *msi/presentation/config/default.json* Einstellung erreichbar unter:
Wenn keine config benutzt werden soll dann
```
app.listen(5000,"localhost")
```
verwenden statt.
```
localhost:5000
```

### TODO
 - Beschrebung für Moviedatabase, run cake befehle
 - reveal-in- ... fehler mit class beheben
 - intsallationsschritte für node js hier aufnehmen
 - jade für präsi: pro Kapitel eine html datei
 - fehler moviedatabase: edit save liefert undefined, disble save button raus, class View
 - kommentare moviedatabase (nicht dringend)
 - classen in verschiedene dateien, geht das mitlerweile?
#### Inhalte
bis Dienstag
 - Einleitung, vortiel nachteile - aw
 - Kapitel in Stichpunkten (genauer) , aw,sss
 - Timeline sss, cs,js, ecma, node, browser?
 - für besipiele filtern, nur cs features, keine js features, sss
 - Grundgerüst präsi: kapitel
 - dropbox quellenliste, sss 1x, aw 0x
Fragen für dozent
  - Gliederung 

