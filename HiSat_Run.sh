#!/bin/bash
#$ -cwd
#$ -o HiSat2_run.$JOB_ID.output
#$ -j y
#$ -pe smp-verbose 10
#$ -N HiSat_Run
#$ -m aes
#$ -q byslot.q@node01

/users/lbuggiotti/hisat2-2.1.0/hisat2 \
 -p 10 -q --phred33 -t --dta \
 --met-file metrics.txt \
 --novel-splicesite-outfile Abomasum_Splice_Sites.tb \
 --un Unused_reads.fq \
 -x /users/dpoppleton/Chevrotain_Annotation/RNASEQ/HiSat2/CHEV_HIC_REF \
 -1 /users/dpoppleton/Chevrotain_Annotation/RNASEQ/raw_data/Abomasum1_1.fq \
 -2 /users/dpoppleton/Chevrotain_Annotation/RNASEQ/raw_data/Abomasum1_2.fq \
 -S Abomasum.SAM
