#!/usr/bin/env python
import os
import subprocess

imagepath = raw_input("Enter the image path with the extention: ")
print("\nGetting profile details")
print("vol -f " + imagepath + " imageinfo")
os.system("vol -f " + imagepath + " imageinfo")

profile = raw_input("\nSelect and enter the profile you want to use: ")
print("\nRunnung kdbg scan on " + profile)
print("vol -f " + imagepath + " --profile=" + profile + " kdbgscan")
os.system("vol -f " + imagepath + " --profile=" + profile + " kdbgscan")

outputpath = raw_input("\nEnter the path to save output files: ")
print("\nGetting hivelist")
print("vol -f " + imagepath + " --profile=" + profile + " hivelist")
hivelist = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " hivelist", shell=True)
print(hivelist)
f = open(outputpath + "/hivelist.txt", "w")
f.write(hivelist)
f.close()
hivesamsys = subprocess.check_output("cat hivelist.txt | grep -i 'config\\\SYSTEM\|config\\\SAM' | wc -l", shell=True)
hivesamsys = (int(hivesamsys))
if hivesamsys == 2:
	SYSTEM = subprocess.check_output("cat hivelist.txt | grep -i 'config\\\SYSTEM' | cut -d ' ' -f1", shell=True)
	SYSTEM = SYSTEM.strip('\n')
	SAM = subprocess.check_output("cat hivelist.txt | grep -i 'config\\\SAM' | cut -d ' ' -f1", shell=True)
	SAM = SAM.strip('\n')
	print("\nRunnung hashdump")
	print("vol -f " + imagepath + " --profile=" + profile + " hashdump -y " + SYSTEM + " -s " + SAM)
	hashdump = subprocess.call("vol -f " + imagepath + " --profile=" + profile + " hashdump -y " + SYSTEM + " -s " + SAM, shell=True)
	if str(hashdump) == '0':
		print("No user password found")
	else:
		f = open(outputpath + "/password.txt", "w")
		f.write(hashdump)
		f.close()
		print(hashdump)
		print("You may try the hashes with a hash cracker(https://www.objectif-securite.ch)")
		
else:
	print("Skipping hashdump")

print("\nGetting pslist")
print("vol -f " + imagepath + " --profile=" + profile + " pslist")
pslist = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " pslist", shell=True)
if isinstance(pslist, str):
	print(pslist)
	f = open(outputpath + "/pslist.txt", "w")
	f.write(pslist)
	f.close()

print("\nGetting pstree")
print("vol -f " + imagepath + " --profile=" + profile + " pstree")
pstree = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " pstree", shell=True)
if isinstance(pstree, str):
	print(pstree)
	f = open(outputpath + "/pstree.txt", "w")
	f.write(pstree)
	f.close()

print("\nGetting psscan")
print("vol -f " + imagepath + " --profile=" + profile + " psscan")
psscan = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " psscan", shell=True)
if isinstance(psscan, str):
	print(psscan)
	f = open(outputpath + "/psscan.txt", "w")
	f.write(psscan)
	f.close()

print("\nGetting psxview")
print("vol -f " + imagepath + " --profile=" + profile + " psxview --apply-rules")
psxview = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " psxview --apply-rules", shell=True)
if isinstance(psxview, str):
	print(psxview)
	f = open(outputpath + "/psxview.txt", "w")
	f.write(psxview)
	f.close()

print("\nGetting connscan")
print("vol -f " + imagepath + " --profile=" + profile + " connscan")
connscan = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " connscan", shell=True)
if isinstance(connscan, str):
	print(connscan)
	f = open(outputpath + "/connscan.txt", "w")
	f.write(connscan)
	f.close()

print("\nGetting netscan")
print("vol -f " + imagepath + " --profile=" + profile + " netscan")
netscan = subprocess.call("vol -f " + imagepath + " --profile=" + profile + " netscan", shell=True)
if isinstance(netscan, str):
	print(netscan)
	f = open(outputpath + "/netscan.txt", "w")
	f.write(netscan)
	f.close()

print("\nGetting malprocfind")
print("vol -f " + imagepath + " --profile=" + profile + " malprocfind")
malprocfind = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " malprocfind", shell=True)
if isinstance(malprocfind, str):
	print(malprocfind)
	f = open(outputpath + "/malprocfind.txt", "w")
	f.write(malprocfind)
	f.close()

print("\nGetting sids")
print("vol -f " + imagepath + " --profile=" + profile + " getsids")
sids = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " getsids", shell=True)
if isinstance(sids, str):
	print(sids)
	f = open(outputpath + "/sids.txt", "w")
	f.write(sids)
	f.close()

print("\nGetting processes views")
print("vol -f " + imagepath + " --profile=" + profile + " psscan --output=dot --output-file")
processes = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " psscan --output=dot --output-file=" + outputpath + "/processes.dot", shell=True)
print("You can try 'xdot /path-to-file/processes.dot' to view process list in graphically")

print("\nGetting autoruns")
print("vol -f " + imagepath + " --profile=" + profile + " autoruns")
autoruns = subprocess.check_output("vol -f " + imagepath + " --profile=" + profile + " autoruns", shell=True)
if isinstance(autoruns, str):
	print(autoruns)
	f = open(outputpath + "/autoruns.txt", "w")
	f.write(autoruns)
	f.close()
