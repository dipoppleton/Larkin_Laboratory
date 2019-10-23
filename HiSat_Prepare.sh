#!/bin/bash
#$ -cwd
#$ -o HiSat2_Build.$JOB_ID.output
#$ -j y
#$ -pe smp-verbose 64
#$ -N HiSat_Build
#$ -m aes
#$ -q byslot.q@node05

/users/lbuggiotti/hisat2-2.1.0/hisat2-build  --large-index -p 64 -f /users/dpoppleton/Chevrotain_Annotation/mouse_deer_HiRise_all_masked.fa /users/dpoppleton/Chevrotain_Annotation/RNASEQ/HiSat2/CHEV_HIC_REF
