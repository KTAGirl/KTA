import json
import shutil

with open('../MO2/Kick Their Ass.compiler_settings', 'r') as rfile:
    kta_cs = json.load(rfile)

with open('Kick Their Ass.compiler_settings', 'w') as wfile:
    json.dump(kta_cs, wfile, sort_keys=True, indent=4)

shutil.copyfile("../MO2/profiles/KTA-FULL/loadorder.txt","loadorder.txt")
shutil.copyfile("../MO2/profiles/KTA-FULL/modlist.txt","modlist.txt")

shutil.copytree('../MO2/mods/KTA-MCM', 'KTA-MCM', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-firewood', 'KTA-firewood', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-Pacifist', 'KTA-Pacifist', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-FemaleOppression', 'KTA-FemaleOppression', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-LALPatch', 'KTA-LALPatch', dirs_exist_ok=True)

wait = input("Press Enter to continue.")
