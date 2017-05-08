Nodejs installieren

npm install

#### Symlinks benötigt:
sudo ln -s /home/<path inside your home folder>/msi/presentation/code/Moviedatabase/node_modules/coffee-script/bin/cake /usr/local/bin/cake
sudo ln -s /home/<path inside your home folder>/msi/presentation/code/Moviedatabase/node_modules/docco/bin/docco /usr/local/bin/docco
sudo ln -s /home/<path inside your home folder>/msi/presentation/code/Moviedatabase/node_modules/mocha/bin/mocha /usr/local/bin/mocha

#### Cake Befehle:
 - cake --map build
 - cake --map watch
 - cake docs
 - cake test
 - cake clean
 - 
#### Sourcemaps
 - probleme in firefox 53.0.2 (in chrome funktioniert alles)
 - sourcemap angaben passen nicht zum webserver (files liegen in public ordner)
 - coffeescript Option -M (inline sourcemaps) ging nicht
 - andere sprachen bieten mehr optionen für sourcemaps.

#### See Dokumentation
Running the Application the documentation off the client can be seen at 
localhost:5001/app.html