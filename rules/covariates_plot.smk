ALL.extend([expand('{directory}{sample}{extension}',
                  directory = BAM_DIR,
                  sample = SAMPLE_IDS,
                  extension = '.bqsr.plots.pdf'),])
                    
rule covariates_plot:
    input:
        pre = BAM_DIR + '{sample}.bqsr.table',
        cov = BAM_DIR + '{sample}.BQSR.analyzecovariates.csv',
    output:
        BAM_DIR + '{sample}.bqsr.plots.pdf'
    params:
        script = config['input_dir']['scripts'] + 'BQSR.R',
    conda:
        'envs/bqrsscript_env.yml'
    benchmark:
        BENCH_DIR + 'bqsr/{sample}.bqsrCovariatesPlotBenchmark.txt',
    shell:
        """
        Rscript {params.script} \
        {input.cov} \
        {input.pre} \
        {output}
        """
