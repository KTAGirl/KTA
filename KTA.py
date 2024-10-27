#import json
#import shutil
#import re
#import os
#import glob
#import hashlib

import sys
sys.path.append('../')
import mo2git

'''
def file_noncrypto_hash(filename):
    bufsz = 1048576  # lets read stuff in 1M chunks!

    hash = hashlib.shake_256()

    with open(filename, 'rb') as f:
        while True:
            buf = f.read(bufsz)
            if not buf:
                break
            hash.update(buf)
    return hash.hexdigest(16)

def validate_eslfication(orig_mod,esp_name,orig_hash,eslified_hash):
    old_esp = MO2+'mods/' + orig_mod + '/' + esp_name
    hash = file_noncrypto_hash(old_esp)
    if(hash!=orig_hash):
        print(hash)
        assert(False)
    assert(not mo2git.isEslFlagged(old_esp))
    new_esp = MO2+'mods/KTA-eslify-optionals/' + esp_name
    hash = file_noncrypto_hash(new_esp)
    if(hash!=eslified_hash):
        print(hash)
        assert(False)
    assert(mo2git.isEslFlagged(new_esp))
    
# validate that ESL-fication is still valid (that original ESPs are not changed)
# if it fails - something has changed, ESP needs to be re-ESL-ified
validate_eslfication('Blubbos Whiterun 2022','Blubbos_NewWhiterun_2022.esp','684bc59df513004ac3a12002afd5226f','4446c0bbb675380df9b0b1921fcf0f40')
validate_eslfication('SFO Summer Edition II','Skyrim Flora Overhaul.esp','a0d1d3347beb4005564de87731a76fe7','dd7a35016b47faec7fc8e271b57d7d2a')
validate_eslfication('Flower Fields SE','FlowerFields.esp','df76ff44b124b95e9dd55e5d01c684e8','a4e65f61d52559bf6fa35e6e25645207')
validate_eslfication('Blubbo Trees Variations','Blubbo_Trees_Variations_Nexus.esp','4927d8f225db5f7c785162600861f19e','4b1fcee67fcf4950359288d17e3af37f')
validate_eslfication('Blubbos Markarth 2022','Blubbos_Markarth_2022.esp','cedf99cbad27bde4f008dc1119933d24','08da2a823c3b15b67f45fd74e0e71d2b')
validate_eslfication('Blubbos Riften Trees 2022','Blubbos_Riften_Trees_2022.esp','cd5cf20e10d5e71aef6f791ca1c116f5','9b324d0c2c835699ff2dd1bab18a93d3')
validate_eslfication('Blubbos Riverwood 2023','Blubbos_Riverwood_2023.esp','271e671ad7a489c355eda870e968ef45','d2131b7bf21fd55051fa48278d310ad5')
validate_eslfication('Blubbos Solitude','blubbos_trees_in_solitude.esp','6ee4b20866b5fd5da0b0df85440fe367','27cea0442a19470b9b41b3e245a482ff')
validate_eslfication('02 Asmodeus Pornstars Pack 2 NPC replacer ESP','Asmodeus_PornStars_Pack2_Replacer.esp','642246b7c0cf93ec9513b867856d3109','cbeb978cdbbecbd756b1c417c3e12ce0')
eslified = glob.glob(MO2+'mods/KTA-eslify-optionals/*')
assert(len(eslified)==9) #was any other eslified esp added to the folder without changing Python? Make sure to add validate_eslfication before changing the assert
'''

thisscriptdir = mo2git.scriptDirFrom__file__(__file__)
MO2=thisscriptdir+'../../MO2/'
config = { 'mo2': MO2, 'compiler_settings':'Kick Their Ass.compiler_settings', 'downloads': MO2+'downloads\\', 
           'github': thisscriptdir, 'cache':thisscriptdir+'../mo2git.cache/' }
config['ownmods'] = ['KTA-MCM','KTA-firewood','KTA-Pacifist','KTA-FemaleOppression','KTA-Seduce',
                    'KTA-LALPatch','KTA-DF-Patch','KTA-eslify-optionals','KTA-ENB-Settings-for-PRT-XII']
config['toolinstallfiles'] = ['loot_0.24.0-win64.7Z','SSEEdit 4.1.5f-164-4-1-5f-1714283656.7z','BAE v0.10-974-0-10.7z']
config['genprofiles'] = {'KTA-Lite':'OPTIONAL'}
config['wjcompiled'] = thisscriptdir+'../../KTA/Kick Their Ass.wabbajack.meta.json'
config['statsmods'] = ['Bodyslide Output']

mo2git.run(config)

wait = input("Press Enter to continue.")
