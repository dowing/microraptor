ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule dbnsfp_annotation:
    input:
        top = MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.top_effect.vcf',
        one = MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.snpeff.one_eff_per_line.vcf',
    output:
        top = MUTECT_DIR + '{tumor}_{normal}.variants.top_effect.vcf',
        one = MUTECT_DIR + '{tumor}_{normal}.variants.one_eff_per_line.vcf',
    conda:
        'envs/snpeff_env.yml'
    params:
        db = config['input_dir']['ref'] + 'dbNSFP3.5a_hg19.txt.gz',
        annot = config['dbnsfp_annotation']['annot']
    shell:
        """
        SnpSift dbnsfp \
        -Xmx4g \
        -db {params.db} \
        -f {params.annot} \
        -v {input.top} > {output.top}
        
        SnpSift dbnsfp \
        -Xmx4g \
        -db {params.db} \
        -f {params.annot} \
        -v {input.one} > {output.one}
        """
