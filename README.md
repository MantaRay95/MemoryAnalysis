# MemoryAnalysis
Custom made scripts for analysing and gathering memory artifacts.


pluginsautomate.sh - will run all common plugins in memory analysis and save the outputs in txt formats, so that they can be used to quick manual analysis.

	usage: ./pluginsautomate.sh

basicanalysis.sh - will use a pslist.txt input file and analyze the pslist for abnormal such as abnormal parent child relationships.

	usage: ./basicanalysis.sh path_to_pslist.txt
