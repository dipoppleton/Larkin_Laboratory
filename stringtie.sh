#!/bin/bash
#$ -cwd
#$ -o stringtie.$JOB_ID.output
#$ -j y
#$ -pe smp-verbose 10
#$ -N stringtie
#$ -m aes
#$ -q byslot.q@node01
module load apps/samtools/1.3/gcc-4.4.7 

samtools view -Su Abomasum.SAM | samtools sort -o alns.sorted.bam

/users/lbuggiotti/bin/stringtie alns.sorted.bam \
 -p 10 -l CAB1 \
 -o Abomasum.gtf \
 -a Abomasum_abundance.txt

