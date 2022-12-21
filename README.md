# Simple Persistent System (WIP)
This is a small Arma 3 presistent system that allow for mission state to be saved to the server namespace. The script save Player positions loadout as well as vehicles and enemy units.

## Installation
In order to install this script package you only need to [download the latest build](https://github.com/AndreasBrostrom/SimplePersistentSystem/releases/latest) it and place the content in your mission folder located:
`%USERPROFILE%\Documents\Arma 3 - Other Profiles\[MY ARMA3 USER NAME]\missions\[MY MISSION NAME].[ISLAND]`

*Note! If you have a `description.ext` file included in your mission folder, they will be need to be replaced or edited in order to install this.*

# Usage

##Chat commands
| Command       | User  | Description                                 |
| ------------- | ----- | ------------------------------------------- |
| `#savMission` | `any` | Save the mission and all plauer states      |
| `#save`       | `any` | Save your player position and state         |

## Event Handlers

### Players
Players are saved a little bit now and then ussaly via event.

| Save events       | Description                                                                            |
| ----------------- | -------------------------------------------------------------------------------------- |
| `PlayerConnected` | When you connect your are saved or loaded. Based on if you played befor or not.        |
| `MPRespawn`       | After you respawn your new state is saved.                                             |
| `GetOutMan`       | When you get in to a vehicle.                                                          |
| `GetInMan`        | When you get out of a vehicle.                                                         |
| `InventoryClosed` | When you close your inventory.                                                         |
| chat command      | Manually via chat command.                                                             |
