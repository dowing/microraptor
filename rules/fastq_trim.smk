ALL.extend([expand('{directory}{sample}{read}{extension}',
                  directory = FASTQ_TRIM,
                  sample = SAMPLE_IDS,
                  read = ['_R1','_R2'],
                  extension = ['_trimmed.fastq','_unpaired.fastq'])])
                    
rule fastq_trim:
    input:
        R1 = FASTQ_DIR + '{sample}_R1.fastq',
        R2 = FASTQ_DIR + '{sample}_R2.fastq'
    output:
        R1_trimmed = FASTQ_TRIM + '{sample}_R1_trimmed.fastq',
        R2_trimmed = FASTQ_TRIM + '{sample}_R2_trimmed.fastq',
        R1_unpaired = FASTQ_TRIM + '{sample}_R1_unpaired.fastq',
        R2_unpaired = FASTQ_TRIM + '{sample}_R2_unpaired.fastq'
    params:
        illuminaclip = config['input_dir']['ref'] + config['fastq_trim']['illuminaclip'],
        leading = config['fastq_trim']['leading'],
        trailing = config['fastq_trim']['trailing'],
        slidingwindow = config['fastq_trim']['slidingwindow'],
        minlen = config['fastq_trim']['minlen'],
        score = config['fastq_trim']['score']
    threads: config['thread_info']['fastq_trim']
    conda:
        'envs/trimmomatic_env.yml'
    log:
        LOG_DIR + 'fastq_trim/{sample}.fastq_trim.log'
    benchmark:
        BENCH_DIR + 'fastq_trim/{sample}.fastq_trimBenchmark.txt'
    shell:
        """
        trimmomatic PE \
        -{params.score} \
        {input.R1} \
        {input.R2} \
        {output.R1_trimmed} \
        {output.R1_unpaired} \
        {output.R2_trimmed} \
        {output.R2_unpaired} \
        ILLUMINACLIP:{params.illuminaclip} \
        LEADING:{params.leading} \
        TRAILING:{params.trailing} \
        SLIDINGWINDOW:{params.slidingwindow} \
        MINLEN:{params.minlen} \
        -threads {threads} \
        2> {log}
        """
