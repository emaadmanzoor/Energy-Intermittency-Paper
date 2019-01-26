scp ../model/stdcge_beccs_ne.gms TheWorkers@172.19.138.112:Documents/Saketh
ssh TheWorkers@172.19.138.112 '
export PATH=$PATH:"/Applications/GAMS25.1/GAMS Terminal.app/../sysdir" && cd ~/Documents/Saketh
gams stdcge_beccs_ne.gms'
scp TheWorkers@172.19.138.112:Documents/Saketh/stdcge_beccs_ne.lst ../model/stdcge_beccs_ne.lst 
scp TheWorkers@172.19.138.112:Documents/Saketh/results.gdx ../../data/cge/results_ne.gdx 