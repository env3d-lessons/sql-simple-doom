# Data Modelling And Sample Project

Create a data model for the SIMPLE DOOM game scenario described below.  Identify the entities (both strong and weak), attributes, and relationships that will be needed to support the game (ideally with a ER diagram).

Then implement the data model in SQLite and provide a sample solution along with initial data.

You also need to provide a sample queries for all the different activites that the player can take in the game.  For example, we will need to retrieve all the monsters for the player's current level.

## SIMPLE DOOM

Inspired by [https://github.com/cedardb/sqldoom/tree/main](https://github.com/cedardb/sqldoom/tree/main)

### Scenario: The UDF Outpost on Phobos

**DOOM** takes place across a series of military installations on Phobos. Each **Level** in the game represents a distinct battleground with a unique name (such as *"Hangar"*) and a target par time.

You play as the **Doomguy**, a space marine dropped into the level with one mission: **eliminate every demon on the map to clear the level**.

#### The Player (Doomguy)

The player maintains an active state while surviving the level:

* **Status:** A current **Health** percentage (0–100%) value.
* **Position:** Current $(X, Y)$ spatial coordinates on the map.
* **Direction:** The facing angle in degrees (0–359°) indicating where the player is looking.
* **Loadout:** An inventory of owned weapons and current ammo stocks.

#### Map Entities & Placed Objects

Every level contains three distinct categories of objects placed at specific $(X, Y)$ coordinates:

1. **Monsters:** Enemies spawned throughout the level (such as *Imps*, *Pinkies*, and *Cacodemons*). While each demon species defines base specs like `max_health` and `base_damage`, each placed monster on the map tracks its own `current_health`, facing `direction` (0–359°), and spatial `(X, Y)` position. When a monster's health reaches 0, it is dead.
2. **Weapons:** Firearm pickups scattered across the map (such as the *Pistol*, *Shotgun* or *Plasma Rifle*). Each weapon type defines base properties like `damage_per_shot` and `ammo_type`, while an individual weapon lying on the ground stores its specific `(X, Y)` coordinates and the `num_ammo` loaded into that pickup.
3. **Obstacles:** Static environment features (like pillars, crates, or hazard barriers). Each obstacle record stores its `(X, Y)` location alongside its physical `width` and `height` footprint to handle collision so entities cannot walk through it.

#### Level Completion

Once the player eliminates all monsters in a level, the level is considered **cleared**. We will need to track the next level to load, the player's current health and ammo, and any other persistent state that carries over between levels.

In SIMPLE DOOM, the player loses if their health reaches 0, or they took too long to complete the level (exceeding the par time).