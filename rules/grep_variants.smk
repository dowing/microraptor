ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.annotated.gene_lists.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.annotated.gene_lists.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule grep_variants:
    input:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.annotated.tsv',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.annotated.tsv',
    output:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.annotated.gene_lists.tsv',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.annotated.gene_lists.tsv',
    params:
        genes = config['grep_variants']['genes']
    shell:
        """
        head -n 1 {input.top} > {output.top}
        grep -f {params.genes} -wi {input.top} >> {output.top}
        head -n 1 {input.one} > {output.one}
        grep -f {params.genes} -wi {input.one} >> {output.one}
        """
