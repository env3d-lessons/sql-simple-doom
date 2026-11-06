A sample solution along initial data is stored in doom.sql.

You can create the database using the following command:

```bash
sqlite3 simple_doom.db < doom.sql
```

Run the following command to start a local web server and view the game in your browser:

```bash
python3 -m http.server 8000
```

Then visit [http://localhost:8000](http://localhost:8000) in your browser to play the game.  Or if running inside codespaces, go to the "Ports" tab and click on the "Open in Browser" button next to port 8000.