# load packages #### four hashtags bookmarks below so can get back there more easily
install.packages ("RSQLite")
install.packages ("DBI")
library(DBI) 

# Establish a database connection ####
cow_cig_db <- dbConnect(RSQLite::SQLite(),
                        "CoW_CIG.db") # connects to SQLite

# Modifying the database ####
# Will eventually need to add all tables, and add conditions for each variable
# like did with the "CHECK" function, but starting with just the predator related data:

# run this code when you have your data where "X" is your data tables ####
#dbExecute(cow_cig_db, "Select * FROM X;")
#dbWriteTable(cow_cig_db, "X", X, append = TRUE)

# Creating a new table in the database
dbExecute(cow_cig_db, "CREATE TABLE cameras (
                          deploy_id integer PRIMARY KEY AUTOINCREMENT,
                          camera_id varchar(10),
                          ranch_id varchar(10),
                          station_id varchar(5),
                          date_deploy text, 
                          person_deploy varchar(10) CHECK (person_deploy IN ('Rae', 'tech1', 'tech2')),
                          date_pull text,
                          person_remove varchar(10) CHECK (person_remove IN ('Rae', 'tech1', 'tech2')),
                          lat double,
                          long double,
                          pasture_id varchar(10),
                          dist_target_m char(3),
                          height_f char(3),
                          width char(3),
                          cover_percent char(20),
                          direction varchar(20) CHECK (direction IN ('N', 'S', 'E', 'W', 'NW', 
                          'NE', 'SW', 'SE')),
                          habitat varchar(20),
                          lock char(1),
                          S_B_date text,
                          date_check text,
                          person_check text CHECK (person_check IN ('Rae', 'tech1', 'tech2')), 
                          total_pics char(20),
                          pics_delete char(20),
                          date_dead text,
                          date_full text,
                          FOREIGN KEY (ranch_id) REFERENCES ranches(ranch_id),
                          FOREIGN KEY (camera_id) REFERENCES cameras(camera_id),
                          FOREIGN KEY (person_deploy) REFERENCES cameras(person_deployed),
                          FOREIGN KEY (pasture_id) REFERENCES pastures(pasture_id),
                          FOREIGN KEY (person_remove) REFERENCES cameras(person_removed)
                          );")

dbExecute(cow_cig_db, "CREATE TABLE photos (
                          photo_id integer PRIMARY KEY AUTOINCREMENT,
                          ranch_id varchar(20),
                          camera_id varchar(10),
                          date text,
                          observer_id varchar(10) CHECK (observer_id IN ('Rae', 'tech1', 'tech2')),
                          weather_id varchar(10),
                          temp char(3),
                          time char(4),
                          lat double,
                          long double,
                          species_id varchar(10),
                          pred_num char(3),
                          num_other char(3),
                          num_calves char(3),
                          num_bulls char(3),
                          num_cows char(3),
                          num_cattle char(3),
                          event char(5),
                          event_start char(4),
                          event_end char(4),
                          eat_up_bulls char(3), 
                          eat_up_cows char(3),
                          eat_up_calves char(3),
                          eat_down_bulls char(3), 
                          eat_down_cows char(3),
                          eat_down_calves char(3),
                          stand_up_bulls char(3), 
                          stand_up_cows char(3),
                          stand_up_calves char(3),
                          stand_down_bulls char(3), 
                          stand_down_cows char(3),
                          stand_down_calves char(3),
                          walk_up_bulls char(3), 
                          walk_up_cows char(3),
                          walk_up_calves char(3),
                          walk_down_bulls char(3), 
                          walk_down_cows char(3),
                          walk_down_calves char(3),
                          lying_bulls char(3), 
                          lying_cows char(3),
                          lying_calves char(3),
                          running_bulls char(3), 
                          running_cows char(3),
                          running_calves char(3),
                          other_bulls char(3), 
                          other_cows char(3),
                          other_calves char(3),
                          dom_behav varchar(10),
                          FOREIGN KEY (ranch_id) REFERENCES ranches(ranch_id),
                          FOREIGN KEY (camera_id) REFERENCES cameras(camera_id),
                          FOREIGN KEY (observer_id) REFERENCES cameras(observer_id),
                          FOREIGN KEY (species_id) REFERENCES photos(species_id),
                          FOREIGN KEY (num_calves) REFERENCES photos(num_calves),
                          FOREIGN KEY (num_cows) REFERENCES photos(num_cows),
                          FOREIGN KEY (num_bulls) REFERENCES photos(num_bulls),
                          FOREIGN KEY (num_other) REFERENCES photos(num_other),
                          FOREIGN KEY (num_cattle) REFERENCES photos(num_cattle),
                          FOREIGN KEY (pred_num) REFERENCES photos(pred_num)
                          );")

