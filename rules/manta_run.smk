ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule manta_run:
    input:
        MANTA_DIR + '{tumor}_{normal}_config/runWorkflow.py',
    output:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf.gz',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf.gz',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf.gz',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf.gz',
    threads: config['thread_info']['manta']
    conda:
        'envs/manta_env.yml'
    benchmark:
        BENCH_DIR + 'manta_run/{tumor}_{normal}.manta_runBenchmark.txt',
    shell:
        """
        {input} \
        -m local \
        -j {threads}
        """
