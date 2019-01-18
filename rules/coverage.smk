ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = '.mkdp.HSmetrics.tsv'),])
                    
rule coverage:
    input:
        BAM_DIR + '{sample}.mkdp.bam',
    output:
        BAM_DIR + '{sample}.mkdp.HSmetrics.tsv',
    params:
        baitintervals = config['coverage']['baitintervals'],
        targetintervals = config['coverage']['targetintervals'],
        tmp = BAM_DIR + '{sample}_mkdp.metrics'
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'coverage/{sample}.coverageBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk CollectHsMetrics \
        -I={input} \
        -O={output} \
        --BAIT_INTERVALS={params.baitintervals} \
        --TARGET_INTERVALS={params.targetintervals} \
        --TMP_DIR={params.tmp}
        rm -rf {params.tmp}
        """
