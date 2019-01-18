ALL.extend([expand('{directory}{tumor}{extension}',
                  directory = MUTECT_DIR,
                  tumor = TUMORS,
                  extension = ['.seqartifactmetrics.bait_bias_detail_metrics',
                               '.seqartifactmetrics.bait_bias_summary_metrics',
                               '.seqartifactmetrics.pre_adapter_detail_metrics',
                               '.seqartifactmetrics.pre_adapter_summary_metrics'])])
                    
rule sequencing_artifacts:
    input:
        BAM_DIR + '{tumor}.recal.bam',
    output:
        expand('{directory}{tumor}{extension}',
               directory = MUTECT_DIR,
               tumor = '{tumor}',
               extension = ['.seqartifactmetrics.bait_bias_detail_metrics',
                            '.seqartifactmetrics.bait_bias_summary_metrics',
                            '.seqartifactmetrics.pre_adapter_detail_metrics',
                            '.seqartifactmetrics.pre_adapter_summary_metrics'],)
    params:
        base = MUTECT_DIR + '{tumor}.seqartifactmetrics',
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        intervals = config['sequencing_artifacts']['intervals'],
        tmp = MUTECT_DIR + '{tumor}.tmp',
    conda:
        'envs/gatk_env.yml'
    benchmark:
        BENCH_DIR + 'sequencing_artifacts/{tumor}.sequencing_artifactsBenchmark.txt',
    shell:
        """
        export _JAVA_OPTIONS="-XX:ParallelGCThreads=2"
        gatk CollectSequencingArtifactMetrics \
        -I {input} \
        -O {params.base} \
        -R {params.fasta} \
        --INTERVALS {params.intervals} \
        --TMP_DIR {params.tmp}
        rm -rf {params.tmp}
        """
