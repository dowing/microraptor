ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.contamination.table',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule calculate_contamination:
    input:
        tumor = MUTECT_DIR + '{tumor}.pileups.table',
        normal = MUTECT_DIR + '{normal}.pileups.table'
    output:
        MUTECT_DIR + '{tumor}_{normal}.contamination.table'
    params:
        tmp = MUTECT_DIR + '{tumor}_{normal}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'calculate_contamination/{tumor}_{normal}.calculate_contaminationBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk CalculateContamination \
        -I {input.tumor} \
        -O {output} \
        --matched-normal {input.normal} \
        --TMP_DIR {params.tmp}
        rm -rf {params.tmp}
        """
