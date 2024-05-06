#!/bin/bash
#only accepts fna files

#User Prompts
echo "Enter the directory containing your contigs: "
read inputDir

echo "Enter the path to the output directory: "
read outputDir

echo "Enter the number of CPUs cores to use (0 = all available cores): "
read cpus

#Prepare output directory
mkdir -pv "$outputDir"

echo "Reading Query Files from: $inputDir"
echo "Depositing outputs into: $outputDir"

find "$inputDir" -name "*.fna" -print0 | while read -d $'\0' file
do
    filename=$(basename "$file" .fna)
    echo "Running PROKKA on $filename ..."
    
    # Run PROKKA
    prokka --compliant --outdir "$outputDir/$filename" --prefix "$filename" "$file" --cpus "$cpus" 
    
    echo "#######################"
done

echo "All done!"
