ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.twicefiltered.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule second_filter:
    input:
        vcf = MUTECT_DIR + '{tumor}_{normal}.oncefiltered.vcf.gz',
        preadapter = MUTECT_DIR + '{tumor}.seqartifactmetrics.pre_adapter_detail_metrics'
    output:
        MUTECT_DIR + '{tumor}_{normal}.twicefiltered.vcf.gz'
    params:
        tmp = MUTECT_DIR + '{tumor}_{normal}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'second_filter/{tumor}_{normal}.second_filterBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk FilterByOrientationBias \
        --variant {input.vcf} \
        --pre-adapter-detail-file {input.preadapter} \
        -O {output} \
        --TMP_DIR {params.tmp}
        rm -rf {params.tmp}
        """
