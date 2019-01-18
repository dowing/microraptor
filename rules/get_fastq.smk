ALL.extend([expand('{directory}{sample}{extension}',
                  directory = FASTQ_DIR,
                  sample = SAMPLE_IDS,
                  extension = ['_R1.fastq', '_R2.fastq'])])       

rule get_fastq: 
    output:
        FASTQ_DIR + '{sample}_{read}.fastq',
    params:
        fastq_dir= config['input_dir']['fastq']
    shell:
        """
        zcat {params.fastq_dir}{wildcards.sample}_{wildcards.read}.fastq.gz > {output}
        """
