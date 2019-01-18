ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule snpeff_top_effect:
    input:
        MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.vcf'
    output:
        MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.top_effect.vcf'
    conda:
        'envs/snpeff_env.yml'
    params:
        script = config['input_dir']['snpeff'] + 'vcfAnnFirst.py'
    shell:
        """
        cat {input} | python2 {params.script} > {output}
        """
