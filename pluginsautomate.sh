read -p 'Enter the image path with the extention: ' imagepath
vol.py -f $imagepath imageinfo
read -p 'Select and enter the Profile: ' profile
vol.py -f $imagepath --profile=$profile kdbgscan
out1=$(vol.py -f $imagepath --profile=$profile hivelist | grep 'SYSTEM\|SAM')
echo "$out1"
SYSTEM=$(echo "$out1" | grep 'SYSTEM' | cut -d ' ' -f1)
SAM=$(echo "$out1" | grep 'SAM' | cut -d ' ' -f1)
vol.py -f $imagepath --profile=$profile hashdump -y $SYSTEM -s $SAM
echo "You may try the hashes with a hash cracker(https://www.objectif-securite.ch)"

read -p 'Enter the path to save output: ' outputpath
vol.py -f $imagepath --profile=$profile pslist > $outputpath/pslist.txt
cat $outputpath/pslist.txt
vol.py -f $imagepath --profile=$profile pstree > $outputpath/pstree.txt
cat $outputpath/pstree.txt
vol.py -f $imagepath --profile=$profile psscan > $outputpath/psscan.txt
cat $outputpath/psscan.txt
vol.py -f $imagepath --profile=$profile psscan --output=dot --output-file=$outputpath/processes.dot
echo "You can try \"xdot /path-to-file/processes.dot\" to view process list in graphically"
vol.py -f $imagepath --profile=$profile getsids > 
cat $outputpath/sids.txt
vol.py -f $imagepath --profile=$profile psxview --apply-rules > $outputpath/psxview.txt
cat $outputpath/psxview.txt
vol.py -f $imagepath --profile=$profile netscan > $outputpath/netscan.txt
cat $outputpath/netscan.txt
vol.py -f $imagepath --profile=$profile malprocfind > $outputpath/malprocfind.txt
cat $outputpath/malprocfind.txt
vol.py -f $imagepath --profile=$profile connscan > $outputpath/connscan.txt
cat $outputpath/connscan.txt
vol.py -f $imagepath --profile=$profile autoruns > $outputpath/autoruns.txt
cat $outputpath/autoruns.txt
