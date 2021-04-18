#!/bin/bash
## *** see comments after the code for the problem that is being solved *** ##
# full path to directory that contains the files to be processed
dirName="${1}"

# get the list of files and write to a file in pwd
find "${dirName}/" -maxdepth 1 -type f > "fileNames.lst"
origFileCount=$(wc -l "fileNames.lst")
echo "*******   Original File Count  *******"
echo "*******     ${origFileCount}   *******"
echo "**************************************"

# process the files as specified
fileCount=0
while IFS= read -r line
do
	  # take action on $line #
	    #echo "$line"
	      baseFilename=$(basename "${line}")

	        # get the year/month/day/FScode
		  fileYear=$(echo "${baseFilename}" | awk -F  "." '/1/ {print substr($2,5,2)}')
		    fileMonth=$(echo "${baseFilename}" | awk -F  "." '/1/ {print substr($2,3,2)}')
		      fileDay=$(echo "${baseFilename}" | awk -F  "." '/1/ {print substr($2,1,2)}')
		        fileCode=$(echo "${baseFilename}" | awk -F  "." '/1/ {print $1}')
			  # echo "Dir to create: ${fileYear}/${fileMonth}/${fileDay}/${fileCode}"
			    newDir=${fileYear}/${fileMonth}/${fileDay}/${fileCode}

			      # create the directory
			        mkdir -p "${dirName}/${newDir}"
				  mv "${line}" "${dirName}/${newDir}/"
				    ((fileCount+=1))
			    done < "fileNames.lst"

			    # Results
			    echo "*******    Files Moved Count    *******"
			    echo "*******      ${fileCount}       *******"
			    echo "***************************************"
## ************************************************************************************ ##
# The Situation
# There are 2 million files in one directory. The files are of different types,
# which are reflected by the file names. The file naming convention is:
# AAxyz.ddmmyyFSRV.Z01, where:
# ● AA - file type code
# ● xyz - arbitrary 3-digit code
# ● ddmmyy - date
# ● FSRV.Z01 - constant string
# Sample file names in the directory:
# FS123.010218FSRV.Z01
# FS123.010318FSRV.Z01
# FS123.010418FSRV.Z01
# FS456.010218FSRV.Z01
# FS456.010318FSRV.Z01
# FS456.010418FSRV.Z01
# TS123.010218FSRV.Z01
# TS123.010318FSRV.Z01
# TS123.010418FSRV.Z01
# TS456.010218FSRV.Z01
# TS456.010318FSRV.Z01
# TS456.010418FSRV.Z01
# RS123.010218FSRV.Z01
# RS123.010318FSRV.Z01
# RS123.010418FSRV.Z01
# RS456.010218FSRV.Z01
# RS456.010318FSRV.Z01
# RS456.010418FSRV.Z01
# The Task
# Create a script in the scripting language of your choice which will perform
# the following tasks:
# 1. Create a target directory structure based on the dates included in the
# files:
# a. YY (first year)
# i. MM (first month)
# 1. DD
# a. FS (file code)
# b. TS (file code)
# c. etc.
# 2. DD (next month)
# a. FS (file code)
# b. TS (file code)
# c. etc.
# b. YY (next year)
# i. MM (first month)
# 1. DD
# a. FS (file code)
# b. TS (file code)
# c. etc.
# 2. DD (next month)
# a. FS (file code)
# b. TS (file code)
# c. Etc.
# 2. Copy the files from the source directory to the target directories that
# were created at step 1
# 3. Remove the files from the target directory
# 4. Bonus: Implement a solution to record and verify that all files from the
# source directory were moved to the target directories and no file was
# lost.
# 
