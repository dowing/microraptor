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

```
git clone https://github.com/umich-brcf-bioinf-projects/microraptor.git
cd path/to/microraptor
```

After cding into `microraptor/`, you will see:
 - the Snakefile, `microraptor.smk`
 - the example configfile, `config.yaml`
 - the main snakemake environment from which to execute the pipeline, `snakemake_env`
 - the `rules/` directory, which houses the rules and accompanying environments to be created during the run, in `rules/envs/`. 
 
 The directory structure is shown below:
 ```
$ tree
.
├── config.yaml
├── microraptor.smk
├── README.md
├── rules
│   ├── all_pass.smk
│   ├── analyze_covariates.smk
│   ├── bqsr.smk
│   ├── bwa_align.smk
│   ├── calculate_contamination.smk
│   ├── covariates_plot.smk
│   ├── coverage.smk
│   ├── dbnsfp_annotation.smk
│   ├── envs
│   │   ├── bqrsscript_env.yml
│   │   ├── bwa_env.yml
│   │   ├── fastqc_env.yml
│   │   ├── gatk_env.yml
│   │   ├── jacquard_env.yml
│   │   ├── manta_env.yml
│   │   ├── multiqc_env.yml
│   │   ├── picard_env.yml
│   │   ├── samtools_env.yml
│   │   ├── snpeff_env.yml
│   │   ├── trimmomatic_env.yml
│   │   └── vcftools_env.yml
│   ├── extract_fields_manta.smk
│   ├── extract_fields.smk
│   ├── fastqc.smk
│   ├── fastq_trim.smk
│   ├── first_filter.smk
│   ├── flagstat.smk
│   ├── flanking_sequence.smk
│   ├── get_fastq.smk
│   ├── grep_variants.smk
│   ├── gunzip_manta_vcf.smk
│   ├── jacquard_expand_manta.smk
│   ├── jacquard_expand.smk
│   ├── manta_configure.smk
│   ├── manta_run.smk
│   ├── mark_duplicates.smk
│   ├── merge_expanded_manta.smk
│   ├── merge_expanded.smk
│   ├── mutect2.smk
│   ├── pileup_summary.smk
│   ├── sam_to_bam.smk
│   ├── second_filter.smk
│   ├── sequencing_artifacts.smk
│   ├── snpeff_annotation_manta.smk
│   ├── snpeff_annotation.smk
│   ├── snpeff_one_per_line_manta.smk
│   ├── snpeff_one_per_line.smk
│   ├── snpeff_top_effect_manta.smk
│   └── snpeff_top_effect.smk
├── scripts
│   ├── BQSR.R
│   ├── dbNSFP_sort.pl
│   ├── grep_genes_lists.sh
│   └── vcftools-vcftools-d0c95c5
│       ├── autogen.sh
│       ├── build-aux
│       │   └── git-version-gen
│       ├── configure.ac
│       ├── examples
│       │   ├── annotate2.out
│       │   ├── annotate3.out
│       │   ├── annotate.out
│       │   ├── annotate-test.vcf
│       │   ├── annotate.txt
│       │   ├── cmp-test-a-3.3.vcf
│       │   ├── cmp-test-a.vcf
│       │   ├── cmp-test-b-3.3.vcf
│       │   ├── cmp-test-b.vcf
│       │   ├── cmp-test.out
│       │   ├── concat-a.vcf
│       │   ├── concat-b.vcf
│       │   ├── concat-c.vcf
│       │   ├── concat.out
│       │   ├── consensus.fa
│       │   ├── consensus.out
│       │   ├── consensus.out2
│       │   ├── consensus.vcf
│       │   ├── contrast.out
│       │   ├── contrast.vcf
│       │   ├── fill-an-ac.out
│       │   ├── filters.txt
│       │   ├── fix-ploidy.out
│       │   ├── fix-ploidy.samples
│       │   ├── fix-ploidy.txt
│       │   ├── fix-ploidy.vcf
│       │   ├── floats.vcf
│       │   ├── indel-stats.out
│       │   ├── indel-stats.tab
│       │   ├── indel-stats.vcf
│       │   ├── invalid-4.0.vcf
│       │   ├── isec-n2-test.vcf.out
│       │   ├── merge-test-a.vcf
│       │   ├── merge-test-b.vcf
│       │   ├── merge-test-c.vcf
│       │   ├── merge-test.vcf.out
│       │   ├── parse-test.vcf
│       │   ├── perl-api-1.pl
│       │   ├── query-test.out
│       │   ├── shuffle-test.vcf
│       │   ├── subset.indels.out
│       │   ├── subset.SNPs.out
│       │   ├── subset.vcf
│       │   ├── valid-3.3.vcf
│       │   ├── valid-4.0.vcf
│       │   ├── valid-4.0.vcf.stats
│       │   └── valid-4.1.vcf
│       ├── LICENSE
│       ├── Makefile.am
│       ├── README.md
│       └── src
│           ├── cpp
│           │   ├── bcf_entry.cpp
│           │   ├── bcf_entry.h
│           │   ├── bcf_entry_setters.cpp
│           │   ├── bcf_file.cpp
│           │   ├── bcf_file.h
│           │   ├── bgzf.c
│           │   ├── bgzf.h
│           │   ├── dgeev.cpp
│           │   ├── dgeev.h
│           │   ├── entry.cpp
│           │   ├── entry_filters.cpp
│           │   ├── entry_getters.cpp
│           │   ├── entry.h
│           │   ├── entry_setters.cpp
│           │   ├── gamma.cpp
│           │   ├── gamma.h
│           │   ├── header.cpp
│           │   ├── header.h
│           │   ├── khash.h
│           │   ├── knetfile.c
│           │   ├── knetfile.h
│           │   ├── Makefile.am
│           │   ├── output_log.cpp
│           │   ├── output_log.h
│           │   ├── parameters.cpp
│           │   ├── parameters.h
│           │   ├── variant_file.cpp
│           │   ├── variant_file_diff.cpp
│           │   ├── variant_file_filters.cpp
│           │   ├── variant_file_format_convert.cpp
│           │   ├── variant_file.h
│           │   ├── variant_file_output.cpp
│           │   ├── vcf_entry.cpp
│           │   ├── vcf_entry.h
│           │   ├── vcf_entry_setters.cpp
│           │   ├── vcf_file.cpp
│           │   ├── vcf_file.h
│           │   ├── vcftools.1
│           │   ├── vcftools.cpp
│           │   └── vcftools.h
│           ├── Makefile.am
│           └── perl
│               ├── ChangeLog
│               ├── FaSlice.pm
│               ├── fill-aa
│               ├── fill-an-ac
│               ├── fill-fs
│               ├── fill-ref-md5
│               ├── Makefile.am
│               ├── tab-to-vcf
│               ├── test.t
│               ├── vcf-annotate
│               ├── vcf-compare
│               ├── vcf-concat
│               ├── vcf-consensus
│               ├── vcf-contrast
│               ├── vcf-convert
│               ├── vcf-fix-newlines
│               ├── vcf-fix-ploidy
│               ├── vcf-haplotypes
│               ├── vcf-indel-stats
│               ├── vcf-isec
│               ├── vcf-merge
│               ├── vcf-phased-join
│               ├── Vcf.pm
│               ├── vcf-query
│               ├── vcf-shuffle-cols
│               ├── vcf-sort
│               ├── vcf-stats
│               ├── VcfStats.pm
│               ├── vcf-subset
│               ├── vcf-to-tab
│               ├── vcf-tstv
│               └── vcf-validator
└── snakemake_env.yml
```

2. Create the `snakemake_env` to run **microraptor**. This will create a `conda` environment (named `snakemake_env`) that contains Snakemake, the correct version of Python, and several other dependencies necessary for running the pipeline.
```
conda env create --name snakemake_env --file snakemake_env.yml
```

Check environment installation via:
```
conda info --envs
```

You should see a `snakemake_env` in the list of `conda` environments.


# Usage

1. To run **microraptor**, `anaconda` or `conda` must be loaded. Check for `conda` using:   
```
conda --version
```

Conda can be loaded on Flux with:
```
module load python-anaconda3/latest-3.6
```


2. Load the correct environment, `snakemake_env` (see Installation):
```
source activate snakemake_env
```


3. Once loaded, edit the `config.yaml` file and run the pipeline via:
```
snakemake --configfile config.yaml --snakefile microraptor.smk -p --use-conda --cores 40
```

The `-p` flag is optional. The `-n` flag can be used to perform a `dry-run`, checking to see which rules should be run and how many times. The `--cores` flag can be set as you prefer. 

# Notes

At the moment, the pipeline supports  input of fastq files in the `_R1.fastq.gz` or `_R2.fastq.gz` format. This means that fastq files from multiple lanes must already be concatentated. This can be changed in a later version of the pipeline.  

