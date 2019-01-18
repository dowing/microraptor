ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule extract_fields:
    input:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.vcf',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.vcf',
    output:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.extractFields.tsv',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.extractFields.tsv',
    conda:
        'envs/snpeff_env.yml'
    params:
        fields = config['extract_fields']['fields'],
    shell:
        """
        SnpSift extractFields \
        {input.top} \
        {params.fields} \
        > {output.top}
        
        SnpSift extractFields \
        {input.one} \
        {params.fields} \
        > {output.one}
        """
