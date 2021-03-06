# msi
Assignment for MSI. Presentation made with [reveal.js](http://lab.hakim.se/reveal-js/#/) and a Plugin to [run commands in terminal](https://github.com/dluxemburg/reveal-run-in-terminal).
## Browser Anforderungen
Läuft in Firefox Version 53.x. Probleme mit Version 44.0.2 (ubuntu).
## Installation
Installation getestet für Ubuntu ab 14.04.
### Konfiguration
Ignorier das hier. Standardmäßig auf localhost.
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
Moviedatabase in eigenes Repository versoben. Klonen innerhalb des Ordners */presentation/code/*
Reveal js:
```
git clone https://github.com/chappy2/Moviedatabase.git
```
### Server Installation
#### Coffee Script
Unter Ubuntu ging das npm package coffee-scirpt nicht. Habe es temporär ohne npm installiert:

```
sudo apt-get install coffeescript
```

#### Nodejs und Dependencies

node js mit nvm installieren. 
```
curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash
source ~/.profile
nvm ls-remote
nvm install v4.6.2
nvm use v4.6.2
node --version
```
nvm Version _v4.6.2_ benutzen.
Gegebenenfalls node Version einstellen, falls node Befehle (die noch kommen) nicht funktionieren.
```
nvm ls
nvm use v4.6.2
node --version
```
Im ordner *msi/presentation* und *reveal-run-in-terminal* und *msi/presentation/code/Moviedatabase*
```
npm install
```

Präsentation dann starten mit im *presentation* Ordner
```
node app.js
```
Je nach *msi/presentation/config/default.json* Einstellung erreichbar unter:
```
localhost:5000
```
### Demo
Demo befindet sich im *msi/presentation/code/Moviedatabase* Ordner. 
Hier ist eine Cakefile hinterlegt (build tool von CoffeeScript).
Hier muss ein Symlink hin:
```
sudo ln -s /home/<path inside your home folder>/msi/presentation/code/Moviedatabase/node_modules/coffee-script/bin/cake /usr/local/bin/cake 
```
Für den Demo Server Code kann nun in *msi/presentation/code/Moviedatabase* und dem Client Code *msi/presentation/code/Moviedatabase/public* Ordner cake Befehle, zum build von den jeweiligen *./src/.coffee* Dateien ausgeführt werden.
```
cake build
```
Demo starten mit im *presentation/code/Moviedatabase* Ordner
```
node ./dist/app.js
```
Auch hier kann der node.js Server über config eingestellt werden. Port soll hier 5001 sein.
```
localhost:5001
```
### TODO
#### Fertige Todos
- [x] Beschrebung für Moviedatabase, run cake befehle
- [x] reveal-in- ... fehler mit class beheben. firefox version 44.0.2 ubuntu. Update auf version 53 -> gelöst.
- [x] intsallationsschritte für node js hier aufnehmen
- [x] jade für präsi: pro Kapitel eine html datei
- [x] fehler moviedatabase: edit save liefert undefined
- [x] disble save button raus
- [x] class View
- [x] prod vm neuinstallation testen
- [x] classen in verschiedene dateien, geht das mitlerweile? nein geht nicht. man könnte requirejs einbauen
- [x] Einleitung, vortiel nachteile - aw
- [x] Kapitel in Stichpunkten (genauer) , aw,sss
- [x] Timeline sss, cs,js, ecma, node, browser?
- [x] für besipiele filtern, nur cs features, keine js features, sss
- [x] Grundgerüst präsi: kapitel
- [x] dropbox quellenliste, sss 1x, aw 0x
- [x] folien
- [x] Beispiel aus docx in Quellcode übernehmen (removeCharakters)!
- [x] Termin mit dozent
- [x] Code ausführen geht nicht mehr sss
- [x] Beispiel code für client als literate aw
- [x] quiz erstellen
- [x] Sourcemaps sss
- [x] literate aw
- [x] ecma 6. edition aw
- [x] cs version 2
- [x] Klassen sss
- [x] klassen folien
- [x] task erklären
- [x] tasks folien
- [x] speaker notes einfügen server 
- [x] dokumentation einfügen
- [x] Projekt sourcemaps vorhanden
#### Neue Todos
- [ ] zukunft einleitung aw
- [ ] fazit
- [ ] docco einfügen (nebensatz)
#### Inhalte bis Sonntag
- [x] Demofolien anpassen, link für repo
- [x] logo überdecken ädern (REveal api)
- [x] speaker notes einfügen
- [x] css für plugin
- [x] beamer test
- [x] format code for moviedatabase
- [x] zeiten pro folie (quiz weniger).
- [x] transition bug
- [x] fehler präsi
- [x] +- fazit
- [x] präsi als pdf exportieren
- [x] daten demo localstorage vorbereiten
- [x] repo extra für moviedatabase
- [x] readme mit erklärung
- [x] .litcoffee erstellen
#### Check Montag
- [ ] Quellen seite passt? sourcemaps hinzugefügt!
- [ ] demo höhe iframe (nochmal angepasst)
- [ ] Vergleichsfolie passt? mit den iframes
#### Fragen dozent
- [x] #seiten nur text? 
- [x] quiz ok?
- [x] gliederung ok? einleitung , fazit


