ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.jacquardExpand.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule jacquard_expand_manta:
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
        diploid_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.jacquardExpand.tsv',
        somatic_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.jacquardExpand.tsv',
        candidate_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.jacquardExpand.tsv',
        candidateIndel_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.jacquardExpand.tsv',
        diploid_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        somatic_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        candidate_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        candidateIndel_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.jacquardExpand.tsv',
    conda:
        'envs/jacquard_env.yml'
    shell:
        """
        jacquard expand \
        {input.diploid_top} {output.diploid_top}
        
        jacquard expand \
        {input.somatic_top} {output.somatic_top}
        
        jacquard expand \
        {input.candidate_top} {output.candidate_top}
        
        jacquard expand \
        {input.candidateIndel_top} {output.candidateIndel_top}
        
        jacquard expand \
        {input.diploid_one} {output.diploid_one}
        
        jacquard expand \
        {input.somatic_one} {output.somatic_one}
        
        jacquard expand \
        {input.candidate_one} {output.candidate_one}
        
        jacquard expand \
        {input.candidateIndel_one} {output.candidateIndel_one}
        """
