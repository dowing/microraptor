ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.oncefiltered.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule first_filter:
    input:
        vcf = MUTECT_DIR + '{tumor}_{normal}.Mutect2.raw.vcf.gz',
        contamination = MUTECT_DIR + '{tumor}_{normal}.contamination.table'
    output:
        MUTECT_DIR + '{tumor}_{normal}.oncefiltered.vcf.gz'
    params:
        tmp = MUTECT_DIR + '{tumor}_{normal}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'first_filter/{tumor}_{normal}.first_filterBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk FilterMutectCalls \
        --variant {input.vcf} \
        -O {output} \
        --contamination-table {input.contamination} \
        --TMP_DIR {params.tmp}
        rm -rf {params.tmp}
        """
