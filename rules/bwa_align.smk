ALL.extend([expand('{directory}{sample}{extension}',
                  directory = ALN_DIR,
                  sample = SAMPLE_IDS,
                  extension = '.sam'),])
                    
rule bwa_align:
    input:
        R1 = FASTQ_TRIM + '{sample}_R1_trimmed.fastq',
        R2 = FASTQ_TRIM + '{sample}_R2_trimmed.fastq'
    output:
        ALN_DIR + '{sample}.sam',
    params:
        genome = config['input_dir']['ref'] + 'ucsc.hg19',
        header = '"@RG\\tID:{sample}\\tLB:{sample}\\tSM:{sample}\\tPL:ILLUMINA"'
    conda:
        'envs/bwa_env.yml'
    threads: config['thread_info']['alignment']
    benchmark:
        BENCH_DIR + 'bwa_align/{sample}.bwa_alignBenchmark.txt',
    shell:
        """
        bwa mem \
        -R {params.header} \
        -M \
        {params.genome} \
        {input.R1} \
        {input.R2} \
        -t {threads} \
        > {output}
        """
