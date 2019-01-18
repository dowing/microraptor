ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = ['.mkdp.bam','.mkdp.bai', '_dup_metrics.txt']),])
                    
rule mark_duplicates:
    input:
        BAM_DIR + '{sample}.sorted.bam',
    output:
        bam = BAM_DIR + '{sample}.mkdp.bam',
        bai = BAM_DIR + '{sample}.mkdp.bai',
        metric = BAM_DIR + '{sample}_dup_metrics.txt'
    params:
        removeduplicates = config['mark_duplicates']['removeduplicates'],
        validationstringency = config['mark_duplicates']['validationstringency'],
        createindex = config['mark_duplicates']['createindex'],
        tmp = BAM_DIR + '{sample}_mkdp'
    conda:
        'envs/gatk_env.yml'
    threads: config['thread_info']['sort']
    benchmark:
        BENCH_DIR + 'mark_duplicates/{sample}.mark_duplicatesBenchmark.txt',
    shell:
        """
        gatk MarkDuplicates \
        -I={input} \
        -O={output.bam} \
        --REMOVE_DUPLICATES={params.removeduplicates} \
        --METRICS_FILE={output.metric} \
        --CREATE_INDEX={params.createindex} \
        --VALIDATION_STRINGENCY={params.validationstringency} \
        --TMP_DIR={params.tmp}
        rm -rf {params.tmp}
        """
