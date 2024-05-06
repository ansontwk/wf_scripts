#!/bin/bash
#only accepts faa files

#User Prompts
echo "Enter the directory containing your protein files: "
read inputDir

echo "Enter the path to the output directory: "
read outDir

echo "Enter the number of CPUs cores to use (recommended = 8): "
read cpus

#Prepare output directory
mkdir -pv "$outDir"

echo "Reading Protein Files from : $inputDir"
echo "Depositing outputs into: $outDir"

find "$inputDir" -type f -name "*.faa" | while read -d $'\0' file
do
    filename=$(basename "$file" .faa)
    echo "Running MacSyFinder on $filename at $file"

    #Run Macsyfinder
    macsyfinder --sequence-db "$file" -o "$outDir/$filename" --models TXSScan --db-type ordered_replicon -w "$cpus"

    echo "####################"
done

echo "All Done!"
