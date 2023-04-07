@echo off
title [Notepad Game]

set player_name=Name
set /a player_hp=30
set /a player_max_hp=30
set /a player_damage=5
set /a player_armor=0
set /a player_coins=0

set /a player_lvl=1
set /a player_xp=0
set /a player_target_xp=10

set /a player_lvl_hp=15
set /a player_lvl_damage=3
set /a player_lvl_armor=1

set enemy_name=Orc
set /a enemy_hp=10
set /a enemy_max_hp=10
set /a enemy_damage=3
set /a enemy_armor=0
set /a enemy_drop_xp=0
set /a enemy_drop_coins=0

:Menu
cls
echo Notepad Game
echo 1. Start Game
echo 2. Exit Game
echo.
set /p answer=Select Option:
if %answer%==1 goto :CharacterCreator
if %answer%==2 goto :Exit
if not %answer%==1 goto :Menu

:Exit
cls
exit /b

:GameOver
cls
echo Game Over!
pause
goto :Exit

:CharacterCreator
cls
set /p player_name=What is your name:
goto :Game

:Game
cls
echo Notepad Game!
echo.
echo %player_name%
echo Statistics # Health: %player_hp% # Damage: %player_damage% # Armor: %player_armor%
echo LVL: %player_lvl% # XP:%player_xp%/%player_target_xp% # Coins: %player_coins%
echo.
echo 1. Fight with enemy
echo 2. Back to menu
echo.
set /p answer=Select Option:
if %answer%==1 goto :RandomizeEnemy
if %answer%==2 goto :Menu
if not %answer%==1 goto :Menu

:RandomizeEnemy
set /a random_enemy_index=%random% %%3 +0
echo %random_enemy_index%
if %random_enemy_index%==0 goto Enemy_Create_Orc
if %random_enemy_index%==1 goto Enemy_Create_Goblin
if %random_enemy_index%==2 goto Enemy_Create_Shrek

:Enemy_Create_Orc
set enemy_name=Orc
set /a enemy_hp=18
set /a enemy_max_hp=18
set /a enemy_damage=3
set /a enemy_armor=1
set /a enemy_drop_xp=5
set /a enemy_drop_coins=5

goto :Fight

:Enemy_Create_Goblin
set enemy_name=Goblin
set /a enemy_hp=12
set /a enemy_max_hp=12
set /a enemy_damage=1
set /a enemy_armor=0
set /a enemy_drop_xp=3
set /a enemy_drop_coins=3
goto :Fight

:Enemy_Create_Shrek
set enemy_name=Shrek
set /a enemy_hp=25
set /a enemy_max_hp=25
set /a enemy_damage=3
set /a enemy_armor=1
set /a enemy_drop_xp=10
set /a enemy_drop_coins=15
goto :Fight


:Fight
cls
echo Battle!
echo.
echo %player_name%
echo Statistics # Health: %player_hp% # Damage: %player_damage% # Armor: %player_armor%
echo LVL: %player_lvl% # XP:%player_xp%/%player_target_xp%
echo.
echo %enemy_name%
echo Statistics # Health: %enemy_hp% # Damage %enemy_damage% # Armor %enemy_armor%
echo.
echo 1. Attack
echo 2. Escape
set /p answer=Select Option:
if %answer%==1 goto :Handle_Fight_Attack
if %answer%==2 goto :Handle_Fight_Escape
if not %answer%==1 goto :Fight

:Handle_Fight_Attack
cls
set /a random_enemy_index=%random% %%3 +0

set /a enemy_fight_damage=%random% %%%enemy_damage% + 1 - %player_armor%
if %enemy_fight_damage% LEQ 0 set /a enemy_fight_damage=0

set /a player_fight_damage=%random% %%%player_damage% + 1 - %enemy_armor%
if %player_fight_damage% LEQ 0 set /a player_fight_damage=0

set /a enemy_hp=%enemy_hp% - %player_fight_damage%
if %enemy_hp% LEQ 0 goto :Handle_Enemy_Defeat

set /a player_hp=%player_hp% - %enemy_fight_damage%
if %player_hp% LEQ 0 goto :GameOver

echo Player attacked: %player_fight_damage%
echo Enemy attacked: %enemy_fight_damage%
pause

goto :Fight

:Handle_Fight_Escape
goto :Game

:Handle_Enemy_Defeat
set /a player_coins=%player_coins% + %enemy_drop_coins%
set /a player_xp=%player_xp% + %enemy_drop_xp%
if %player_xp% GEQ %player_target_xp% goto :Player_LevelUp
goto :Game 

:Player_LevelUp
set /a player_xp= 0
set /a player_lvl= %player_lvl% + 1
set /a player_max_hp= %player_max_hp% + %player_lvl_hp%
set /a player_hp= %player_max_hp%
set /a player_damage= %player_damage% + %player_lvl_damage%
set /a player_armor= %player_armor% + %player_lvl_armor%

goto :Game 
