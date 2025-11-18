# rna-seq-trinity-
# de novo assembly full pipeline 
mkdir -p QC/raw_fastqc
mkdir -p QC/trimmed_fastqc
mkdir -p QC/multiqc
mkdir -p trimmed_reads
fastqc -t 8 \
  trimmed_reads/*_paired.fastq.gz \
  -o QC/trimmed_fastqc
fastqc -t 8 \
  trimmed_reads/*_paired.fastq.gz \
  -o QC/trimmed_fastqc
multiqc QC/ -o QC/multiqc
Trinity --seqType fq \
  --left trimmed_reads/Control1_R1_paired.fastq.gz \
  --right trimmed_reads/Control1_R2_paired.fastq.gz \
  --trimmomatic --CPU 8 --max_memory 50G
  # for sample in Control1 Control2 Control3 Treated1 Treated2 Treated3
  trimmomatic PE -threads 8 \
    data/${sample}_R1.fastq.gz data/${sample}_R2.fastq.gz \
    trimmed_reads/${sample}_R1_paired.fastq.gz trimmed_reads/${sample}_R1_unpaired.fastq.gz \
    trimmed_reads/${sample}_R2_paired.fastq.gz trimmed_reads/${sample}_R2_unpaired.fastq.gz \
    ILLUMINACLIP:/usr/share/trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:36
    Trinity \
  --seqType fq \
  --left reads_1.fq.gz \
  --right reads_2.fq.gz \
  --max_memory 50G \
  --CPU 6 \
  --trimmomatic
  # otput trinity_out_dir/Trinity.fasta
# run salmon after salomn the expect output
# sampleA    cond1    readsA_1.fq.gz    readsA_2.fq.gz
# sampleB    cond1    readsB_1.fq.gz    readsB_2.fq.gz
# sampleC    cond2    readsC_1.fq.gz    readsC_2.fq.gz
...
# for aducdance estimation 
$TRINITY_HOME/Analysis/TranscriptExpression/align_and_estimate_abund.pl \
  --transcripts trinity_out_dir/Trinity.fasta \
  --seqType fq \
  --samples_file samples.txt \
  --est_method Salmon \
  --output_dir salmon_outdir
# using trinity auto rapper for DESeq2
$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl \
  --matrix salmon_outdir/Trinity.gene.counts.matrix \
  --method DESeq2 \
  --pairwise \
  --output DESeq2_results
  # or edgeR
$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl \
  --matrix salmon_outdir/Trinity.gene.counts.matrix \
  --method edgeR \
  --pairwise \
  --output edgeR_results
# Generates pairwise DE tables, MA-plots, heatmaps, volcano plots
# Predict Coding Regions Using TransDecoder
# Step 1: Identify long ORFs
TransDecoder.LongOrfs -t Trinity.fasta 
# cd trinity_out_dir
# functinal anotation 
mkdir trinotate
cd trinotate

cp ../trinity_out_dir/Trinity.fasta ......










