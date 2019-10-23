#!/bin/bash
#$ -cwd
#$ -o stringtie.$JOB_ID.output
#$ -j y
#$ -N gtf_2_gff3
#$ -m aes

/users/dpoppleton/Programs/gffread \
 -E Abomasum.gtf \
 -o Abomasum.gff3

