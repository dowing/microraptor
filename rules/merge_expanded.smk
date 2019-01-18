ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule merge_expanded:
    input:
        top_jac = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.jacquardExpand.tsv',
        one_jac = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.jacquardExpand.tsv',
        top_ext = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.extractFields.tsv',
        one_ext = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.extractFields.tsv',
    output:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.annotated.tsv',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.annotated.tsv',
    shell:
        """
        paste {input.top_ext} {input.top_jac} > {output.top}
        paste {input.one_ext} {input.one_jac} > {output.one}
        """
