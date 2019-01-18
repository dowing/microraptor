#DropSeq pre-processing
#Christopher Sifuentes cjsifuen@umich.edu

from __future__ import print_function, absolute_import, division
from argparse import Namespace
import collections
from collections import defaultdict
import csv
from functools import partial
import glob
import hashlib
import os
from os.path import basename
from os.path import isfile
from os.path import join
from os.path import splitext
import shutil
import sys
import subprocess
import yaml
import datetime
import time
import snakemake
import pandas as pd

#email
EMAIL = config.get('email_address')

#get parameters from config file
TODAY = datetime.date.today()
DEFAULT_JOB_SUFFIX = 'analysis_{:02d}_{:02d}/'.format(TODAY.month, TODAY.day)
SUFFIX = config['analysis_dir_suffix']

#pjdir
if not SUFFIX:
    PJ_SUFFIX = DEFAULT_JOB_SUFFIX
else:
    PJ_SUFFIX = SUFFIX

PJ_DIR = config.get('project_dir')

#make other dir names
ANALYSIS_DIR = PJ_DIR + PJ_SUFFIX
REF_DIR = ANALYSIS_DIR + 'reference/'
FASTQ_DIR = ANALYSIS_DIR + 'fastq/'
FASTQ_TRIM = ANALYSIS_DIR + 'fastq_trimmed/'
ALN_DIR = ANALYSIS_DIR + 'alignment/'
BAM_DIR = ANALYSIS_DIR + 'bam/'
MUTECT_DIR = ANALYSIS_DIR + 'mutect2/'
MANTA_DIR = ANALYSIS_DIR + 'manta/'
QC_DIR = ANALYSIS_DIR + 'fastq_qc/'
LOG_DIR = ANALYSIS_DIR + 'logs/'
BENCH_DIR = ANALYSIS_DIR + 'benchmarks/'

#make pjdir
if not os.path.exists(ANALYSIS_DIR):
    os.makedirs(ANALYSIS_DIR)

#organism base names
ORG = config['genome']

#get sample base names, need to edit this to get it from config, place them in new folder called fastq
FASTQ_GZ = list(config['samples'].values())
FASTQ_GZ = [y for x in FASTQ_GZ for y in x]

SAMPLE_IDS = list(config['samples'].keys())
PAIRS = config.get('pairings')
TUMORS = PAIRS.keys()
NORMALS = PAIRS.values()
UNIQ_IDS = list(set(list(TUMORS) + list(NORMALS)))


#set empty all list
ALL = []

#load rules
include: 'rules/get_fastq.smk'
include: 'rules/fastqc.smk'
include: 'rules/fastq_trim.smk'
include: 'rules/bwa_align.smk'
include: 'rules/sam_to_bam.smk' 
include: 'rules/mark_duplicates.smk'
include: 'rules/flagstat.smk'
include: 'rules/coverage.smk'
include: 'rules/bqsr.smk'
include: 'rules/analyze_covariates.smk'
include: 'rules/covariates_plot.smk'

#pairs
include: 'rules/mutect2.smk'
include: 'rules/pileup_summary.smk'
include: 'rules/calculate_contamination.smk'
include: 'rules/first_filter.smk'
include: 'rules/sequencing_artifacts.smk'
include: 'rules/second_filter.smk'
include: 'rules/all_pass.smk'
include: 'rules/flanking_sequence.smk'
include: 'rules/snpeff_annotation.smk'
include: 'rules/snpeff_one_per_line.smk'
include: 'rules/snpeff_top_effect.smk'
include: 'rules/dbnsfp_annotation.smk'
include: 'rules/extract_fields.smk'
include: 'rules/jacquard_expand.smk'
include: 'rules/merge_expanded.smk'

#sv analysis
include: 'rules/manta_configure.smk'
include: 'rules/manta_run.smk'
include: 'rules/gunzip_manta_vcf.smk'
include: 'rules/snpeff_annotation_manta.smk'
include: 'rules/snpeff_one_per_line_manta.smk'
include: 'rules/snpeff_top_effect_manta.smk'
include: 'rules/extract_fields_manta.smk'
include: 'rules/jacquard_expand_manta.smk'
include: 'rules/merge_expanded_manta.smk'

#format results
#include: 'rules/grep_variants.smk'

#rule all
rule all:
    input:
        ALL,

#email success
onsuccess:
    syscmd2 = "echo -e 'Exome Seq: workflow complete.' | mutt -s 'Workflow finished, no error' " + EMAIL
    os.system(syscmd2)

onerror:
    syscmd2 = "echo -e 'Exome Seq: workflow error.' | mutt -s 'Workflow failed with error' " + EMAIL
    os.system(syscmd2)
