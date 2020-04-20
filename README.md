# redemrp_register

## 1. Requirements

[redem-roleplay](https://github.com/RedEM-RP/redem_roleplay/)

[redemrp_identity](https://github.com/RedEM-RP/redemrp_identity/)

[redemrp_inventory](https://github.com/RedEM-RP/redemrp_inventory)

[redemrp_notification](https://github.com/Ktos93/redemrp_notification/)

[progressBars](https://github.com/shredxt/progressBars)


## 2. Installation
-Copy this folder into your resources folder.
-start redemrp_register in your server.cfg
-In the redemrp_inventory in fxmanifest you must paste this at the end
    server_exports {
	'getInventory'
    }

-And you must add this into the server.lua of redemrp_inventory 
    function getInventory()
        return invTable
    end

## 3. How to use
Press J and register other dead bodys of players and get all their inventory

## 4. Credits
All people that created redemrp and all comunity

## 5.Future inprovment 
Change the animation, I was very tired and i copy the redemrp_inventory animation, tomorrw I will upload the new animation