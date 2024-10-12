import json
import re

with open('../MO2/profiles/KTA-FULL/modlist.txt') as f0:
    lines = [line.rstrip() for line in f0]
    
# print(lines)

lines = list(filter(lambda s: s.startswith('+'),lines))
lines.append('@loot_0.24.0-win64.7Z')
lines.append('@SSEEdit 4.1.5f-164-4-1-5f-1714283656.7z')
lines.append('@BAE v0.10-974-0-10.7z')

# print(lines)

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
            # print(mod)
            modmetaname = '../MO2/mods/' + mod + '/meta.ini'
            try:
                with open(modmetaname) as modmeta:
                    modmetalines = [line.rstrip() for line in modmeta]
            except:
                modmetalines = []
            installfiles = list(filter(lambda s: s.startswith('installationFile='),modmetalines))
        assert(len(installfiles)<=1)
        if(len(installfiles)==1):
            installfile = installfiles[0]
            assert(installfile.startswith('installationFile='))
            installfile = installfile[len('installationFile='):]
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
                    m = re.search(r'^manualURL *= *(.*)',manualurl)
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
                    urls=list(filter(lambda s: s.startswith('url='),filemetalines))
                    if len(urls) == 0:
                        print('WARNING: neither manualURL nor url in '+filemetaname)
                    else:
                        assert(len(urls)==1)
                        url = urls[0]
                        if not url.startswith('url="https://cf-files.nexusmods.com/'):
                            print('WARNING: non-Nexus url '+url[len('url='):]+'in '+filemetaname)


    rowidx = 1
    for manualurl in todl:
        prompts = todl[manualurl]
        # print(manualurl+' '+str(prompts))
        xprompt = ''
        for prompt in prompts:
            if len(xprompt) > 0:
                xprompt = xprompt + '<br>'
            xprompt = xprompt + ':lips:' + prompt
        md.write('|'+str(rowidx)+'|['+manualurl+']('+manualurl+')|'+xprompt+'|\n')
        rowidx = rowidx + 1
    
