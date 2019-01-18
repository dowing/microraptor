ALL.extend([expand('{directory}{uniq_id}{extension}',
                  directory = MUTECT_DIR,
                  uniq_id = UNIQ_IDS,
                  extension = '.pileups.table')])
                    
rule pileup_summary:
    input:
        BAM_DIR + '{uniq_id}.recal.bam',
    output:
        MUTECT_DIR + '{uniq_id}.pileups.table'
    params:
        intervals = config['mutect2']['intervals'], 
        germline = config['mutect2']['germline'],
        tmp = MUTECT_DIR + '{uniq_id}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'pileup_summary/{uniq_id}.pileup_summaryBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk GetPileupSummaries \
        -I {input} \
        -O {output} \
        --intervals {params.intervals} \
        --variant {params.germline} \
        --TMP_DIR {params.tmp}
        rm -rf {params.tmp}
        """
