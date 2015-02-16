# Setting up database returns so that they are hashes such as {"column_name" => "row_value"}
DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS people
                  id INTEGER PRIMARY KEY,
                  name TEXT NOT NULL,
                  convention_id INTEGER NOT NULL,
                  panel_id INTEGER NOT NULL")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS conventions
                  id INTEGER PRIMARY KEY,
                  name TEXT NOT NULL,
                  address TEXT NOT NULL,
                  loc_lat NUMBER NOT NULL,
                  loc_lon NUMBER NOT NULL")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS panels
                  id INTEGER PRIMARY KEY,
                  person_id INTEGER,
                  convention_id INTEGER,
                  alias TEXT")