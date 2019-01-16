# microraptor
Exome-seq somatic SNP/Indel and somatic SV calling pipeline according to GATK best practices, using T/N pairs.

# Overview

The **microraptor** pipeline accepts fastq files, and emits filtered and annotated SNP/Indels as well as SVs. 

The pipeline is based up the chapter written by Peter Ulintz, Weisheng Wu, and Chris Gates - "Bioinformatics Analysis of Whole Exome Sequencing Data", published in Springer Nature Experiments, 2018
https://experiments.springernature.com/articles/10.1007/978-1-4939-8876-1_21

**microraptor** performs the following steps:
_Read QC steps_
 - Read quality asessment (FastQC)
 - Read trimming (Trimmomatic)

 _Exome Sequencing Analysis_
 - Read alignment (BWA mem)
 - Alignment file sorting and indexing (GATK SortSam)
 - Marking duplicate reads (GATK MarkDuplicates)
 - Alignment metrics and coverage calculation (SAMtools flagstat and GATK CollectHsMetrics)
 - Base quality score recalibration (GATK BaseRecalibrator and ApplyBQSR)
 - Covariate analysis and plots (GATK AnalyzeCovariates and plotting script)
 - Collect sequencing errors (GATK CollectSequencingArtifactMetrics)
 - Call variants (GATK Mutect2)
 - Pileup summary (GATK GetPileupSummaries)
 - Estimate contamination (GATK CalculateContamination)
 - Filter variants (GATK FilterMutectCalls)
 - Additional filtering (GATK FilterByOrientationBias)
 - Add flanking sequences (VCFTools fill-fs)
 - Basic annotation and impact prediction (SnpEff snpeff)
 - Extend to one effect per line, keeping all effects for each variant (vcfEffOnePerLine.pl)
 - Extract top effect per variant (vcfAnnFirst.py)
 - dbNSFP annotation (SnpSift dbnsfp)
 - Extract VCF fields to .txt file (SnpSift extractFields)
 - Expand VCF fields to .txt file (jacquard expand)
 - Merge extracted and expanded fields from .txt files

_Structural Variant Analysis_
 - Set up manta configuration file (configManta.py)
 - Run SV calling (runWorkflow.py)
 - Gunzip results (gzip -dc)
 - Basic annotation and impact prediction (SnpEff snpeff)
 - Extend to one effect per line, keeping all effects for each variant (vcfEffOnePerLine.pl)
 - Extract top effect per variant (vcfAnnFirst.py)
 - Extract VCF fields to .txt file (SnpSift extractFields)
 - Expand VCF fields to .txt file (jacquard expand)
 - Merge extracted and expanded fields from .txt files

**microraptor** is implemented in Snakemake and makes use of several bioinformatic tools. Two main files (`microraptor.smk` and `config.yaml`) and a host of supporting files/directories (`rules/`, `snakemake_env.yml`) are necessary. See below.