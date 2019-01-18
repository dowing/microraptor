ALL.extend([expand('{directory}{sample}_{read}',
                  directory = QC_DIR,
                  sample = SAMPLE_IDS,
                  read = ['R1_fastqc.zip', 'R2_fastqc.zip'])])

rule fastqc:
    input:
        fastq = FASTQ_DIR + '{sample}_{read}.fastq',
    output:
        fastq = QC_DIR + '{sample}_{read}_fastqc.zip',
    params:
        qc_dir = QC_DIR,
        format = 'fastq',
    conda:
        'envs/fastqc_env.yml'
    log:
        LOG_DIR + 'fastqc/{sample}_{read}.fastqc.log'
    threads: config['thread_info']['fastqc']
    benchmark:
        BENCH_DIR + 'fastqc/{sample}_{read}.fastqcBenchmark.txt'
    shell:
        """
        mkdir -p {params.qc_dir}
        fastqc \
        --noextract \
        -f {params.format} \
        -o {params.qc_dir} \
        -t {threads} \
        {input.fastq} \
        2> {log}
        """
