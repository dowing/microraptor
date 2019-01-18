ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = '.BQSR.analyzecovariates.csv'),])
                    
rule analyze_covariates:
    input:
        pre = BAM_DIR + '{sample}.bqsr.table',
        post = BAM_DIR + '{sample}.postbqsr.table'
    output:
        intermediate = BAM_DIR + '{sample}.BQSR.analyzecovariates.csv',
    params:
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        tmp = BAM_DIR + '{sample}_table',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'bqsr/{sample}.bqsrAnalyzeCovariatesBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk AnalyzeCovariates \
        --before-report-file {input.pre} \
        --after-report-file {input.post} \
        --intermediate-csv-file {output.intermediate} \
        --TMP_DIR={params.tmp}
        rm -rf {params.tmp}
        """
