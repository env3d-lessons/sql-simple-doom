CREATE TABLE levels (
    id INT PRIMARY KEY, 
    name TEXT NOT NULL, 
    exit_x FLOAT, 
    exit_y FLOAT
);

CREATE TABLE level_transitions (
    from_level_id INT REFERENCES levels(id),
    to_level_id INT REFERENCES levels(id),
    PRIMARY KEY (from_level_id, to_level_id)
);

CREATE TABLE monster_types (
    id INT PRIMARY KEY, 
    name TEXT NOT NULL, 
    max_hp INT NOT NULL, 
    color TEXT NOT NULL,
    move_speed FLOAT NOT NULL DEFAULT 1.0,
    damage_pct INT NOT NULL DEFAULT 10
);

CREATE TABLE weapon_types (
    id INT PRIMARY KEY, 
    name TEXT NOT NULL, 
    base_damage INT NOT NULL, 
    color TEXT NOT NULL
);

CREATE TABLE player (
    id INT PRIMARY KEY, 
    current_level_id INT REFERENCES levels(id),
    health INT NOT NULL DEFAULT 100, 
    x_pos FLOAT NOT NULL, 
    y_pos FLOAT NOT NULL, 
    direction FLOAT NOT NULL DEFAULT 0,
    move_speed FLOAT NOT NULL DEFAULT 2.5,
    turn_speed FLOAT NOT NULL DEFAULT 4.0,
    active_weapon_type_id INT REFERENCES weapon_types(id)
);

CREATE TABLE loadout (
    player_id INT REFERENCES player(id), 
    weapon_type_id INT REFERENCES weapon_types(id), 
    ammo_count INT NOT NULL DEFAULT 0, 
    PRIMARY KEY (player_id, weapon_type_id)
);

CREATE TABLE monsters (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    level_id INT REFERENCES levels(id), 
    monster_type_id INT REFERENCES monster_types(id), 
    x_pos FLOAT NOT NULL, 
    y_pos FLOAT NOT NULL, 
    direction FLOAT NOT NULL DEFAULT 0, 
    remaining_hp INT NOT NULL,
    last_scan_time FLOAT NOT NULL DEFAULT 0
);

CREATE TABLE weapons (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    level_id INT REFERENCES levels(id), 
    weapon_type_id INT REFERENCES weapon_types(id), 
    x_pos FLOAT NOT NULL, 
    y_pos FLOAT NOT NULL, 
    ammo_count INT NOT NULL
);

CREATE TABLE obstacles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    level_id INT REFERENCES levels(id),
    x_pos FLOAT NOT NULL, 
    y_pos FLOAT NOT NULL, 
    width FLOAT NOT NULL, 
    height FLOAT NOT NULL
);

-- INITIAL DATA
INSERT INTO levels VALUES 
    (1, 'E1M1: Hangar', 550, 350),
    (2, 'E1M2: Nuclear Plant', 550, 50);

INSERT INTO level_transitions VALUES (1, 2);

INSERT INTO monster_types (id, name, max_hp, color, move_speed, damage_pct) VALUES 
    (1, 'Zombieman', 15, '#16a34a', 1.0, 5), 
    (2, 'Imp', 30, '#d97706', 1.2, 10);

INSERT INTO weapon_types VALUES (1, 'Pistol', 10, '#facc15'), (2, 'Shotgun', 35, '#3b82f6');

INSERT INTO player (id, current_level_id, health, x_pos, y_pos, direction, move_speed, turn_speed, active_weapon_type_id) 
VALUES (1, 1, 100, 100, 200, 0, 2.5, 4.0, 1);

INSERT INTO loadout VALUES (1, 1, 50);

INSERT INTO monsters (level_id, monster_type_id, x_pos, y_pos, direction, remaining_hp, last_scan_time) VALUES
    (1, 1, 250, 100, 90, 15, 0),
    (1, 2, 450, 250, 180, 30, 0);
    
INSERT INTO weapons (level_id, weapon_type_id, x_pos, y_pos, ammo_count) VALUES
    (1, 2, 250, 300, 16);
    
INSERT INTO obstacles (level_id, x_pos, y_pos, width, height) VALUES
    (1, 180, 120, 40, 160);

INSERT INTO monsters (level_id, monster_type_id, x_pos, y_pos, direction, remaining_hp, last_scan_time) VALUES
    (2, 1, 200, 80, 180, 15, 0),
    (2, 2, 350, 180, 270, 30, 0),
    (2, 2, 400, 320, 180, 30, 0),
    (2, 1, 150, 300, 0, 15, 0);

INSERT INTO weapons (level_id, weapon_type_id, x_pos, y_pos, ammo_count) VALUES
    (2, 2, 100, 350, 20);

INSERT INTO obstacles (level_id, x_pos, y_pos, width, height) VALUES
    (2, 280, 0, 30, 220),
    (2, 100, 180, 120, 30);