# Setting up database returns so that they are hashes such as {"column_name" => "row_value"}
DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS people
                  (id INTEGER PRIMARY KEY,
                  name TEXT NOT NULL CHECK(name!=''),
                  convention_id INTEGER,
                  panel_id INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS conventions
                  (id INTEGER PRIMARY KEY,
                  name TEXT UNIQUE NOT NULL CHECK(name!=''),
                  address TEXT NOT NULL CHECK(address!=''),
                  latitude TEXT NOT NULL,
                  longitude TEXT NOT NULL)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS panels
                  (id INTEGER PRIMARY KEY,
                  person_id INTEGER,
                  convention_id INTEGER NOT NULL)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS panels_people
                  (panel_id INTEGER,
                  person_id INTEGER)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS conventions_people
                  (convention_id INTEGER,
                  person_id INTEGER)")