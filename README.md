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
Unter Linux ging das npm package coffee-scirpt nicht. Momentan muss das separat installiert werden.
#### Nodejs und Dependencies
Node js: https://nodejs.org/en/download/package-manager/
Version _v4.6.2_ benutzen.

Im ordner *msi/presentation* 
```
npm install
```

Server dann starten mit
```
node app.js
```

Je nach *msi/presentation/config/default.json* Einstellung erreichbar unter:
```
localhost:5000
```
