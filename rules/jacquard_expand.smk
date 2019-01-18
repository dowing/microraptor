ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule jacquard_expand:
    input:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.vcf',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.vcf',
    output:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.jacquardExpand.tsv',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.jacquardExpand.tsv',
    conda:
        'envs/jacquard_env.yml'
    shell:
        """
        jacquard expand \
        {input.top} {output.top}
        
        jacquard expand \
        {input.one} {output.one}
        """
