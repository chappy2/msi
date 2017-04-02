# msi
Assignment for MSI.
## Installation
### Konfiguration
In msi/presentation/config defaultExample.json kopieren und umbenennen in default.json. Je nach Umgebung die Werte anpassen.

### Abhängigkeiten ohne npm
Zusätzlich benötigt (innerhalb msi ordner. deswegen der unterordner)
jeweils im Ordner msi git clone:
Reveal js Plugin:
https://github.com/dluxemburg/reveal-run-in-terminal

Reveal js:
https://github.com/hakimel/reveal.js

### Server Installation
Node js: https://nodejs.org/en/download/package-manager/
Version v4.6.2 benutzen.

Im ordner msi/presentation 
```
npm install
```

Server dann starten mit
```
node app.js
```

Je nach msi/presentation/config/default.json Einstellung erreichbar unter:
```
localhost:5000
```
