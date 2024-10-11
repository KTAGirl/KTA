import json

with open('../MO2/profiles/KTA-FULL/modlist.txt') as f0:
    lines = [line.rstrip() for line in f0]
    
# print(lines)

lines = list(filter(lambda s: s.startswith('+'),lines))

# print(lines)

with open('manualdl.md', 'w') as md:
    md.write('## Kick Their Asses - Manual Downloads\n')
    md.write('|#| URL | Comment |\n')
    md.write('|-----|-----|-----|\n')
    rowidx = 1

    for mod0 in lines:
        mod = mod0[1:]
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
                manualurls = list(filter(lambda s: s.startswith('manualURL='),filemetalines))
                assert(len(manualurls)<=1)
                if(len(manualurls)==1):
                    manualurl=manualurls[0]
                    assert(manualurl.startswith('manualURL='))
                    manualurl = manualurl[len('manualURL='):]
                    prompts = list(filter(lambda s: s.startswith('prompt='),filemetalines))
                    assert(len(prompts)==1)
                    prompt=prompts[0]
                    assert(prompt.startswith('prompt='))
                    prompt = prompt[len('prompt='):]
                    # print('manualUrl='+manualurl+' prompt='+prompt)
                    md.write('|'+str(rowidx)+'|['+manualurl+']('+manualurl+')|'+prompt+'|\n')
                    rowidx = rowidx + 1
    
