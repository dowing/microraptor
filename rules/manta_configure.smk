ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/runWorkflow.py',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule manta_configure:
    input:
        tumor = BAM_DIR + '{tumor}.recal.bam',
        normal = BAM_DIR + '{normal}.recal.bam'
    output:
        MANTA_DIR + '{tumor}_{normal}_config/runWorkflow.py'
    params:
        runDir = MANTA_DIR + '{tumor}_{normal}_config/',
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        regions = config['manta_configure']['callRegions'], 
    conda:
        'envs/manta_env.yml'
    benchmark:
        BENCH_DIR + 'manta_configure/{tumor}_{normal}.manta_configureBenchmark.txt',
    shell:
        """
        configManta.py \
        --bam {input.normal} \
        --tumorBam {input.tumor} \
        --exome \
        --referenceFasta {params.fasta} \
        --callRegions {params.regions} \
        --runDir={params.runDir}
        """
