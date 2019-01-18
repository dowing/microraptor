ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = ['.sorted.bam','.sorted.bai']),])
                    
rule sam_to_bam:
    input:
        ALN_DIR + '{sample}.sam',
    output:
        bam = BAM_DIR + '{sample}.sorted.bam',
        bai = BAM_DIR + '{sample}.sorted.bai'
    params:
        sortorder = config['sam_to_bam']['sortorder'],
        validationstringency = config['sam_to_bam']['validationstringency'],
        createindex = config['sam_to_bam']['createindex'],
        tmp = BAM_DIR + '{sample}_tmp'
    conda:
        'envs/gatk_env.yml'
    threads: config['thread_info']['sort']
    benchmark:
        BENCH_DIR + 'sam_to_bam/{sample}.sam_to_bamBenchmark.txt',
    shell:
        """
        gatk SortSam \
        -I={input} \
        -O={output.bam} \
        --SORT_ORDER={params.sortorder} \
        --VALIDATION_STRINGENCY={params.validationstringency} \
        --CREATE_INDEX={params.createindex} \
        --TMP_DIR={params.tmp}
        rm -rf {params.tmp}
        """
