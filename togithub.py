import json
import shutil
import re
import os
import glob
import hashlib

import sys
sys.path.append('../wj2git/')
import wj2git
import dbg

# config
MO2='../../MO2/'

# helpers

def dir_size(start_path):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(start_path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            # skip if it is symbolic link
            if not os.path.islink(fp):
                total_size += os.path.getsize(fp)
    return total_size

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
    assert(not wj2git.isEslFlagged(old_esp))
    new_esp = MO2+'mods/KTA-eslify-optionals/' + esp_name
    hash = file_noncrypto_hash(new_esp)
    if(hash!=eslified_hash):
        print(hash)
        assert(False)
    assert(wj2git.isEslFlagged(new_esp))
    
def copy_mod(modname):
    shutil.copytree(MO2+'mods/'+modname, modname, dirs_exist_ok=True)


# helpers end

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

# start collecting stats
stats = dict()

# copy files 

with wj2git.openModTxtFile(MO2+'Kick Their Ass.compiler_settings') as rfile:
    kta_cs = json.load(rfile)
    
stats['VERSION']=kta_cs['Version']

with wj2git.openModTxtFileW('Kick Their Ass.compiler_settings') as wfile:
    json.dump(kta_cs, wfile, sort_keys=True, indent=4)

shutil.copyfile(MO2+'profiles/KTA-FULL/loadorder.txt',"loadorder.txt")

modlist = wj2git.ModList(MO2+'profiles/KTA-FULL/')
modlist.write('') # to current dir

copy_mod('KTA-MCM')
copy_mod('KTA-firewood')
copy_mod('KTA-Pacifist')
copy_mod('KTA-FemaleOppression')
copy_mod('KTA-Seduce')
copy_mod('KTA-LALPatch')
copy_mod('KTA-DF-Patch')
copy_mod('KTA-eslify-optionals')

# process KTA-FULL profile

# optionals
section = ''
optionalmods=0
optionalesxs=0
optionalesxs_dict={}
optionalmods_dict={}
for mod in modlist.modlist:
    separ = wj2git.ModList.isSeparator(mod)
    if separ:
        section = separ
    else:
        if re.search('OPTIONAL',section):
            assert(mod[0]=='+')
            mod = mod[1:]
            optionalmods += 1
            # print('OPTIONAL:'+mod)
            optionalmods_dict[mod] = 1
            esxs=wj2git.allEsxs(mod,MO2)
            for esx in esxs:
                optionalesxs += 1
                key = os.path.split(esx)[1]
                assert(optionalesxs_dict.get(key)==None)
                optionalesxs_dict[key] = esx
        else:
            if mod[0]=='+':
                mod = mod[1:]
                esxs=wj2git.allEsxs(mod,MO2)
                for esx in esxs:
                    key = os.path.split(esx)[1]
                    path = optionalesxs_dict.get(key)
                    if path != None:
                        # print(path + ' is overridden by '+ esx)
                        optionalesxs_dict[key] = esx

            
stats['OPTIONALMODS']=optionalmods
stats['OPTIONALESXS']=optionalesxs

for key in optionalesxs_dict:
    esx = optionalesxs_dict.get(key)
    assert(esx!=None)
    if not wj2git.isEslFlagged(esx):
       print('WARNING: OPTIONAL '+esx+' is not esl-flagged')    
       
# generate KTA-Lite
shutil.copytree(MO2+'profiles/KTA-FULL', MO2+'profiles/KTA-Lite', dirs_exist_ok=True)

# print(modlist)
modlist.writeDisablingIf(MO2+'profiles/KTA-Lite/', lambda mod: optionalmods_dict.get(mod) or mod == 'KTA-eslify-optionals')

# mod sizes - DEBUG
if False:
    size_list=[]
    for mod in modlist.allEnabled():
        size_list.append([mod,round(dir_size(MO2+'mods/'+mod)/1000000,2)])
    #for mod0 in modlist:
    #    if mod0[0]=='+':
    #        size_list.append([mod0[1:],round(dir_size(MO2+'mods/'+mod0[1:])/1000000,2)])
    size_list.sort(key=lambda x: x[1])
    print(size_list)
    dbg.dbgWait()

# generate manualdl.md

# modlist = list(filter(lambda s: s.startswith('+'),modlist))
stats['ACTIVEMODS'] = sum(1 for i in modlist.allEnabled())
modlist.modlist.append('@loot_0.24.0-win64.7Z') # HACK!
modlist.modlist.append('@SSEEdit 4.1.5f-164-4-1-5f-1714283656.7z')
modlist.modlist.append('@BAE v0.10-974-0-10.7z')

# print(modlist)

nsfw_nexus=0
nsfw_ll=0
nsfw_kta=0
nsfw_or_not=0
esxs=0
nsfw_esxs=0
with wj2git.openModTxtFile('nsfw-nexus.json') as rfile:
    nsfw_nexus_dict = json.load(rfile)

with wj2git.openModTxtFileW('manualdl.md') as md:
    md.write('## Kick Their Asses - Manual Downloads\n')
    md.write('|#| URL | Comment |\n')
    md.write('|-----|-----|-----|\n')
    todl = {}

    for mod0 in modlist.modlist:
        mod = mod0[1:]
        if(mod0[0]=='@'):
            installfile=mod
            modid=0
        else:
            if mod0[0]!='+':
                continue
            local_esxs = len(wj2git.allEsxs(mod,MO2))
            esxs += local_esxs
            # print(mod)
            installfile,modid = wj2git.installFileAndModid(mod,MO2)

        manualurl = None
        if not installfile:
            print('WARNING: no installedFiles= found for mod '+mod)
        else:
            flag, manualurl, prompt = wj2git.howToDownload(installfile,MO2)
            match flag:
                case wj2git.HowToDownloadReturn.NoMeta:
                    print("WARNING: no .meta file for "+installfile)
                case wj2git.HowToDownloadReturn.ManualOk:
                    if manualurl not in todl:
                        todl[manualurl]=[]
                    todl[manualurl].append(prompt)                    
                case wj2git.HowToDownloadReturn.NexusOk:
                    pass
                case wj2git.HowToDownloadReturn.NonNexusNonManual:
                    print("WARNING: neither manualURL no Nexus url in "+installfile+".meta")
        
        if modid and str(modid) != '0':
            # print(modid)
            ns = nsfw_nexus_dict.get(modid)
            if ns != None:
                assert(ns == 0 or ns == 1)
                nsfw_nexus += ns
                nsfw_esxs += local_esxs * ns
            else:
                # print(installfile)
                print('WARNING: file '+installfile+' from Nexus modid='+str(modid)+' is not categorized as NSFW or not')
                url = 'https://www.nexusmods.com/skyrimspecialedition/mods/' + str(modid)
                # print(url)
                nsfw_or_not += 1
        else:
            if mod.startswith('KTA'):
                nsfw_kta += 1
                nsfw_esxs += local_esxs
            elif manualurl and manualurl != '':
                if re.search('loverslab',manualurl):
                    nsfw_ll += 1
                    nsfw_esxs += local_esxs

    if nsfw_or_not:
        print('WARNING: NSFW_OR_NOT=' + str(nsfw_or_not))
    stats['NSFWMODS'] = nsfw_nexus + nsfw_ll + nsfw_kta
    stats['NSFWMODSLL'] = nsfw_ll
    stats['NSFWMODSNEXUS'] = nsfw_nexus
    stats['NSFWMODSKTA'] = nsfw_kta
    
    rowidx = 1
    sorted_todl = dict(sorted(todl.items()))
    for manualurl in sorted_todl:
        prompts = sorted_todl[manualurl]
        # print(manualurl+' '+str(prompts))
        xprompt = ''
        for prompt in prompts:
            if len(xprompt) > 0:
                xprompt = xprompt + '<br>'
            xprompt = xprompt + ':lips:' + prompt
        md.write('|'+str(rowidx)+'|['+manualurl+']('+manualurl+')|'+xprompt+'|\n')
        rowidx = rowidx + 1
    
# reading ../../KTA/Kick Their Ass.wabbajack.meta.json
with wj2git.openModTxtFile('../../KTA/Kick Their Ass.wabbajack.meta.json') as rfile:
    kta_stats = json.load(rfile)
stats['WBSIZE'] = f"{kta_stats['Size']/1e9:.1f}G"
stats['DLSIZE'] = f"{kta_stats['SizeOfArchives']/1e9:.0f}G"
stats['INSTALLSIZE'] = f"{kta_stats['SizeOfInstalledFiles']/1e9:.0f}G"
stats['TOTALSPACE'] = f"{round(((kta_stats['Size']+kta_stats['SizeOfArchives']+kta_stats['SizeOfInstalledFiles'])/1e9+5)/5,0)*5:.0f}G"
stats['BODYSLIDESZ'] = f"{dir_size(MO2+'mods/BodySlide Output')/1e9:.1f}G"
stats['ESXS'] = str(esxs)
stats['NSFWESXS'] = str(nsfw_esxs)

# generating README.md
with wj2git.openModTxtFile('README-template.md') as fr:
    readme = fr.read()
for key in stats:
    key1 = '%'+key+'%'
    readme = readme.replace(key1,str(stats[key]))
with wj2git.openModTxtFileW('README.md') as fw:
    fw.write(readme)
    
# print('|Active Mods|'+str(activemods)+'|')

wait = input("Press Enter to continue.")
