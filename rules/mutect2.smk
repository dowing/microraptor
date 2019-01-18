ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.Mutect2.raw.vcf.gz',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule mutect2:
    input:
        tumor = BAM_DIR + '{tumor}.recal.bam',
        normal = BAM_DIR + '{normal}.recal.bam'
    output:
        MUTECT_DIR + '{tumor}_{normal}.Mutect2.raw.vcf.gz'
    params:
        tumor = '{tumor}',
        normal = '{normal}',
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        intervals = config['mutect2']['intervals'], 
        germline = config['mutect2']['germline'],
        tmp = MUTECT_DIR + '{tumor}_{normal}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'mutect2/{tumor}_{normal}.mutect2Benchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk Mutect2 \
        -R {params.fasta} \
        -I {input.tumor} \
        --tumor-sample {params.tumor} \
        -I {input.normal} \
        --normal-sample {params.normal} \
        --intervals {params.intervals} \
        -O {output} \
        --germline-resource {params.germline} \
        --TMP_DIR={params.tmp}
        rm -rf {params.tmp}
        """
