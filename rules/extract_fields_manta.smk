ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.extractFields.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule extract_fields_manta:
    input:
        diploid_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.vcf',
        somatic_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.vcf',
        candidate_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.vcf',
        candidateIndel_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.vcf',
        diploid_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.vcf',
        somatic_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.vcf',
        candidate_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.vcf',
        candidateIndel_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.vcf',
    output:
        diploid_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.extractFields.tsv',
        somatic_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.extractFields.tsv',
        candidate_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.extractFields.tsv',
        candidateIndel_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.extractFields.tsv',
        diploid_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.extractFields.tsv',
        somatic_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.extractFields.tsv',
        candidate_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.extractFields.tsv',
        candidateIndel_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.extractFields.tsv',
    conda:
        'envs/snpeff_env.yml'
    params:
        fields = config['extract_fields']['fields'],
    shell:
        """
        SnpSift extractFields \
        {input.diploid_top} \
        {params.fields} \
        > {output.diploid_top}
        
        SnpSift extractFields \
        {input.somatic_top} \
        {params.fields} \
        > {output.somatic_top}
        
        SnpSift extractFields \
        {input.candidate_top} \
        {params.fields} \
        > {output.candidate_top}
        
        SnpSift extractFields \
        {input.candidateIndel_top} \
        {params.fields} \
        > {output.candidateIndel_top}
        
        SnpSift extractFields \
        {input.diploid_one} \
        {params.fields} \
        > {output.diploid_one}
        
        SnpSift extractFields \
        {input.somatic_one} \
        {params.fields} \
        > {output.somatic_one}
        
        SnpSift extractFields \
        {input.candidate_one} \
        {params.fields} \
        > {output.candidate_one}
        
        SnpSift extractFields \
        {input.candidateIndel_one} \
        {params.fields} \
        > {output.candidateIndel_one}
        """
