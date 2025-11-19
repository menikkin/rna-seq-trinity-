#!/bin/bash
# Trinity Alternative Pipeline Attempts
# Author: <Your Name>
# Description:
#   All alternative Trinity assembly attempts executed when the CDAC
#   server was slow, unresponsive, or batch jobs failed. Each block
#   represents an actual tested configuration with different CPU,
#   memory, normalization, and quantification settings.

module load trinity/2.15.1

# Input FASTQ files (paired-end, merged list)
LEFT="Control1_R1_paired.fq.gz,Control2_R1_paired.fq.gz,Control3_R1_paired.fq.gz,Treated1_R1_paired.fq.gz,Treated2_R1_paired.fq.gz,Treated3_R1_paired.fq.gz"
RIGHT="Control1_R2_paired.fq.gz,Control2_R2_paired.fq.gz,Control3_R2_paired.fq.gz,Treated1_R2_paired.fq.gz,Treated2_R2_paired.fq.gz,Treated3_R2_paired.fq.gz"

# Attempt 1: High CPU and high memory (initial full-scale run)
Trinity \
  --seqType fq \
  --max_memory 240G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 32 \
  --output trinity_CPU32

# Attempt 2: Reduced CPU due to CDAC job queue limitations
Trinity \
  --seqType fq \
  --max_memory 120G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 12 \
  --output trinity_CPU12

# Attempt 3: Assembly without in-silico normalization
Trinity \
  --seqType fq \
  --max_memory 240G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 28 \
  --no_normalize_reads \
  --output trinity_noNorm

# Attempt 4: Light normalization with moderate memory usage
Trinity \
  --seqType fq \
  --max_memory 150G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 20 \
  --normalize_by_read_set \
  --output trinity_norm_lite

# Attempt 5: Assembly without Salmon quantification
Trinity \
  --seqType fq \
  --max_memory 160G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 24 \
  --no_salmon \
  --output trinity_noSalmon

# Attempt 6: Minimal load (no normalization and no Salmon)
Trinity \
  --seqType fq \
  --max_memory 120G \
  --left $LEFT \
  --right $RIGHT \
  --CPU 16 \
  --no_normalize_reads \
  --no_salmon \
  --output trinity_minimal

# Attempt 7: Batch-wise assembly on subset of samples
Trinity \
  --seqType fq \
  --max_memory 180G \
  --left batch1_R1.fq.gz \
  --right batch1_R2.fq.gz \
  --CPU 20 \
  --output trinity_batch1

# Attempt 8: Lightweight local machine test run
Trinity \
  --seqType fq \
  --max_memory 64G \
  --left smallSubset_R1.fq.gz \
  --right smallSubset_R2.fq.gz \
  --CPU 12 \
  --output trinity_localTest

#!/bin/bash
#SBATCH --job-name=trinity_run
#SBATCH --output=trinity_%j.out
#SBATCH --error=trinity_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=200G
#SBATCH --time=96:00:00
#SBATCH --partition=standard

module load trinity/2.15.1

LEFT="Control1_R1_paired.fq.gz,Control2_R1_paired.fq.gz,Control3_R1_paired.fq.gz,Treated1_R1_paired.fq.gz,Treated2_R1_paired.fq.gz,Treated3_R1_paired.fq.gz"
RIGHT="Control1_R2_paired.fq.gz,Control2_R2_paired.fq.gz,Control3_R2_paired.fq.gz,Treated1_R2_paired.fq.gz,Treated2_R2_paired.fq.gz,Treated3_R2_paired.fq.gz"
Trinity \
  --seqType fq \
  --left $LEFT \
  --right $RIGHT \
  --max_memory 200G \
  --CPU 24 \
  --output trinity_cdac_out



