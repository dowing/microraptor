ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule snpeff_one_per_line:
    input:
        MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.vcf'
    output:
        MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.one_eff_per_line.vcf'
    conda:
        'envs/snpeff_env.yml'
    params:
        script = config['input_dir']['snpeff'] + 'vcfEffOnePerLine.pl'
    shell:
        """
        cat {input} | perl {params.script} > {output}
        """
