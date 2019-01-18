ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff_stats.html',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule snpeff_annotation:
    input:
        MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.vcf'
    output:
        stats = MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff_stats.html',
        vcf = MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.vcf'
    conda:
        'envs/snpeff_env.yml'
    params:
        org = ORG
    shell:
        """
        snpEff eff \
        -Xmx4g \
        -v \
        -stats {output.stats} \
        {params.org} \
        {input} > {output.vcf}
        """
