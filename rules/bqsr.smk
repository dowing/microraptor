ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = ['.bqsr.table','.recal.bam', '.postbqsr.table']),])
                    
rule bqsr:
    input:
        mkdp = BAM_DIR + '{sample}.mkdp.bam',
    output:
        table = BAM_DIR + '{sample}.bqsr.table',
        recal = BAM_DIR + '{sample}.recal.bam',
        post = BAM_DIR + '{sample}.postbqsr.table'
    params:
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        excludesites = config['input_dir']['ref'] + 'dbsnp_138.hg19.excluding_sites_after_129.vcf',
        phase1indels = config['input_dir']['ref'] + '1000G_phase1.indels.hg19.sites.vcf',
        goldstandardindels = config['input_dir']['ref'] + 'Mills_and_1000G_gold_standard.indels.hg19.sites.vcf',
        tmp1 = BAM_DIR + '{sample}_table1',
        tmp2 = BAM_DIR + '{sample}_table2',
        tmp3 = BAM_DIR + '{sample}_table3',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'bqsr/{sample}.bqsrBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk BaseRecalibrator \
        -I {input.mkdp} \
        -O {output.table} \
        -R {params.fasta} \
        --known-sites {params.excludesites} \
        --known-sites {params.phase1indels} \
        --known-sites {params.goldstandardindels} \
        --TMP_DIR={params.tmp1}
        rm -rf {params.tmp1}
        
        gatk ApplyBQSR \
        -I {input.mkdp} \
        -O {output.recal} \
        -R {params.fasta} \
        --bqsr-recal-file {output.table} \
        --TMP_DIR={params.tmp2}
        rm -rf {params.tmp2}
        
        gatk BaseRecalibrator \
        -I {output.recal} \
        -O {output.post} \
        -R {params.fasta} \
        --known-sites {params.excludesites} \
        --known-sites {params.phase1indels} \
        --known-sites {params.goldstandardindels} \
        --TMP_DIR={params.tmp3}
        rm -rf {params.tmp3}
        """
