# MemoryAnalysis
Custom made scripts for analysing and gathering memory artifacts.


pluginsautomate.py - will check for user passwords and will run all common plugins in memory analysis and save the outputs in txt formats, so that they can be used to quick manual analysis.
	
	usage: ./pluginsautomate.py


basicanalysis.sh - will use a pslist.txt input file and analyze the pslist for abnormal such as abnormal parent child relationships.
	
	usage: ./basicanalysis.sh path_to_pslist.txt


linux_memory - a linux memory collecter(using avml(by microsoft)) with artifacts gathering for profile creation.
