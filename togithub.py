import json
import shutil
import re
import os
import glob

def dir_size(start_path):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(start_path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            # skip if it is symbolic link
            if not os.path.islink(fp):
                total_size += os.path.getsize(fp)
    return total_size

# stats
stats = dict()

# copy files 

with open('../MO2/Kick Their Ass.compiler_settings', 'r') as rfile:
    kta_cs = json.load(rfile)
    
stats['VERSION']=kta_cs['Version']

with open('Kick Their Ass.compiler_settings', 'w') as wfile:
    json.dump(kta_cs, wfile, sort_keys=True, indent=4)

shutil.copyfile("../MO2/profiles/KTA-FULL/loadorder.txt","loadorder.txt")
#shutil.copyfile("../MO2/profiles/KTA-FULL/modlist.txt","modlist.txt")
with open('../MO2/profiles/KTA-FULL/modlist.txt','r') as rfile:
    lines = [line.rstrip() for line in rfile]
# print(lines)
lines = list(filter(lambda s: s.endswith('_separator') or not s.startswith('-'),lines))
with open('modlist.txt','w') as wfile:
    for line in lines:
        wfile.write(line+'\n')

shutil.copytree('../MO2/mods/KTA-MCM', 'KTA-MCM', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-firewood', 'KTA-firewood', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-Pacifist', 'KTA-Pacifist', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-FemaleOppression', 'KTA-FemaleOppression', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-Seduce', 'KTA-Seduce', dirs_exist_ok=True)
shutil.copytree('../MO2/mods/KTA-LALPatch', 'KTA-LALPatch', dirs_exist_ok=True)

# process KTA-FULL profile
    
lines = list(filter(lambda s: s.startswith('+'),lines))
stats['ACTIVEMODS'] = len(lines)
lines.append('@loot_0.24.0-win64.7Z')
lines.append('@SSEEdit 4.1.5f-164-4-1-5f-1714283656.7z')
lines.append('@BAE v0.10-974-0-10.7z')

# print(lines)

nsfw_nexus=0
nsfw_ll=0
nsfw_or_not=0
esxs=0
nsfw_esxs=0
with open('nsfw-nexus.json', 'r') as rfile:
    nsfw_nexus_dict = json.load(rfile)

with open('manualdl.md', 'w') as md:
    md.write('## Kick Their Asses - Manual Downloads\n')
    md.write('|#| URL | Comment |\n')
    md.write('|-----|-----|-----|\n')
    todl = {}

    for mod0 in lines:
        mod = mod0[1:]
        if(mod0[0]=='@'):
            installfiles=['installationFile='+mod]
        else:
            local_esxs = len(glob.glob('../MO2/mods/' + mod + '/*.esl'))
            local_esxs += len(glob.glob('../MO2/mods/' + mod + '/*.esp'))
            local_esxs += len(glob.glob('../MO2/mods/' + mod + '/*.esm'))
            esxs += local_esxs
            # print(mod)
            modmetaname = '../MO2/mods/' + mod + '/meta.ini'
            try:
                with open(modmetaname) as modmeta:
                    modmetalines = [line.rstrip() for line in modmeta]
            except:
                modmetalines = []
            # installfiles = list(filter(lambda s: s.startswith('installationFile='),modmetalines))
            installfiles = list(filter(lambda s: re.search('^installationFile *= *',s),modmetalines))
        assert(len(installfiles)<=1)
        manualurl = ''
        if(len(installfiles)==1):
            installfile = installfiles[0]
            # assert(installfile.startswith('installationFile='))
            # installfile = installfile[len('installationFile='):]
            m = re.search('^installationFile *= *(.*)',installfile)
            installfile = m.group(1)
            if(installfile.startswith('C:/Modding/MO2/downloads/')):
                installfile = installfile[len('C:/Modding/MO2/downloads/'):]
            #if(installfile.startswith('../MO2/downloads/')):
            #    installfile = installfile[len('../MO2/downloads/'):]
            # print('mod:'+mod+' if='+installfile)
            if(installfile!=''):
                filemetaname = '../MO2/downloads/' + installfile + '.meta'
                try:
                    with open(filemetaname) as filemeta:
                        filemetalines = [line.rstrip() for line in filemeta]
                except:
                        print('WARNING: file '+filemetaname+' NOT FOUND')
                # print(filemetalines)
                # manualurls = list(filter(lambda s: s.startswith('manualURL='),filemetalines))
                manualurls = list(filter(lambda s: re.search('^manualURL *=',s),filemetalines))
                assert(len(manualurls)<=1)
                if(len(manualurls)==1):
                    manualurl=manualurls[0]
                    # assert(manualurl.startswith('manualURL='))
                    # manualurl = manualurl[len('manualURL='):]
                    m = re.search('^manualURL *= *(.*)',manualurl)
                    manualurl = m.group(1)
                    # print(manualurl)
                    # prompts = list(filter(lambda s: s.startswith('prompt='),filemetalines))
                    prompts = list(filter(lambda s: re.search('^prompt *=',s),filemetalines))
                    assert(len(prompts)==1)
                    prompt=prompts[0]
                    m = re.search('^prompt *= *(.*)',prompt)
                    prompt = m.group(1)
                    # assert(prompt.startswith('prompt='))
                    # prompt = prompt[len('prompt='):]
                    # print('manualUrl='+manualurl+' prompt='+prompt)
                    if manualurl not in todl:
                        todl[manualurl]=[]
                    todl[manualurl].append(prompt)
                else:
                    assert(len(manualurls)==0)
                    # urls=list(filter(lambda s: s.startswith('url='),filemetalines))
                    urls = list(filter(lambda s: re.search('^url *=',s),filemetalines))
                    if len(urls) == 0:
                        print('WARNING: neither manualURL nor url in '+filemetaname)
                    else:
                        assert(len(urls)==1)
                        url = urls[0]
                        #if not url.startswith('url="https://cf-files.nexusmods.com/'):
                        if not re.search('^url *= *"https://cf-files.nexusmods.com/',url):
                            print('WARNING: non-Nexus url '+url[len('url='):]+'in '+filemetaname)
        
        modids = list(filter(lambda s: re.search('^modid *= *',s),modmetalines))
        assert(len(modids)<=1)
        modid = 0
        if(len(modids)==1):
            m = re.search('^modid *= *(.*)',modids[0])
            if m:
                modid = m.group(1)
        if str(modid) != '0':
            # print(modid)
            ns = nsfw_nexus_dict.get(modid)
            if ns != None:
                assert(ns == 0 or ns == 1)
                nsfw_nexus += ns
                nsfw_esxs += local_esxs * ns
            else:
                print(installfile)
                url = 'https://www.nexusmods.com/skyrimspecialedition/mods/' + str(modid)
                print(url)
                nsfw_or_not += 1
        else:
            if manualurl != '':
                if re.search('loverslab',manualurl):
                    nsfw_ll += 1
                    nsfw_esxs += local_esxs

    if nsfw_or_not:
        print('WARNING: NSFW_OR_NOT=' + str(nsfw_or_not))
    stats['NSFWMODS'] = nsfw_nexus + nsfw_ll
    stats['NSFWMODSLL'] = nsfw_ll
    stats['NSFWMODSNEXUS'] = nsfw_nexus

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
    
# reading ../KTA/Kick Their Ass.wabbajack.meta.json
with open('../KTA/Kick Their Ass.wabbajack.meta.json', 'r') as rfile:
    kta_stats = json.load(rfile)
stats['WBSIZE'] = f"{kta_stats['Size']/1e9:.1f}G"
stats['DLSIZE'] = f"{kta_stats['SizeOfArchives']/1e9:.0f}G"
stats['INSTALLSIZE'] = f"{kta_stats['SizeOfInstalledFiles']/1e9:.0f}G"
stats['TOTALSPACE'] = f"{round((kta_stats['Size']+kta_stats['SizeOfArchives']+kta_stats['SizeOfInstalledFiles'])/1e9+5,-1):.0f}G"
stats['BODYSLIDESZ'] = f"{dir_size('../MO2/mods/BodySlide Output')/1e9:.1f}G"
stats['ESXS'] = str(esxs)
stats['NSFWESXS'] = str(nsfw_esxs)

# generating README.md
with open('README-template.md', 'r') as fr:
    readme = fr.read()
for key in stats:
    key1 = '%'+key+'%'
    readme = readme.replace(key1,str(stats[key]))
with open('README.md', 'w') as fw:
    fw.write(readme)
    
# print('|Active Mods|'+str(activemods)+'|')

wait = input("Press Enter to continue.")
