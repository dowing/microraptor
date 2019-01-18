ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = '.mkdp.flagstat'),])
                    
rule flagstat:
    input:
        BAM_DIR + '{sample}.mkdp.bam',
    output:
        BAM_DIR + '{sample}.mkdp.flagstat',
    conda:
        'envs/samtools_env.yml'
    threads: config['thread_info']['sort']
    benchmark:
        BENCH_DIR + 'mark_duplicates/{sample}.mark_duplicatesBenchmark.txt',
    shell:
        """
        samtools flagstat \
        -@ {threads} \
        {input} > {output}
        """
