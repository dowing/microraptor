ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.annotated.tsv',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)],)
                    
rule merge_expanded_manta:
    input:
        diploid_top_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.jacquardExpand.tsv',
        somatic_top_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.jacquardExpand.tsv',
        candidate_top_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.jacquardExpand.tsv',
        candidateIndel_top_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.jacquardExpand.tsv',
        diploid_one_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        somatic_one_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        candidate_one_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.jacquardExpand.tsv',
        candidateIndel_one_jac = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.jacquardExpand.tsv',
        diploid_top_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.extractFields.tsv',
        somatic_top_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.extractFields.tsv',
        candidate_top_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.extractFields.tsv',
        candidateIndel_top_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.extractFields.tsv',
        diploid_one_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.extractFields.tsv',
        somatic_one_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.extractFields.tsv',
        candidate_one_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.extractFields.tsv',
        candidateIndel_one_ext = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.extractFields.tsv',
    output:
        diploid_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.annotated.tsv',
        somatic_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.annotated.tsv',
        candidate_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.annotated.tsv',
        candidateIndel_top = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.annotated.tsv',
        diploid_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.annotated.tsv',
        somatic_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.annotated.tsv',
        candidate_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.annotated.tsv',
        candidateIndel_one = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.annotated.tsv',
    shell:
        """
        paste {input.diploid_top_ext} {input.diploid_top_jac} > {output.diploid_top}
        paste {input.somatic_top_ext} {input.somatic_top_jac} > {output.somatic_top}
        paste {input.candidate_top_ext} {input.candidate_top_jac} > {output.candidate_top}
        paste {input.candidateIndel_top_ext} {input.candidateIndel_top_jac} > {output.candidateIndel_top}
        paste {input.diploid_one_ext} {input.diploid_one_jac} > {output.diploid_one}
        paste {input.somatic_one_ext} {input.somatic_one_jac} > {output.somatic_one}
        paste {input.candidate_one_ext} {input.candidate_one_jac} > {output.candidate_one}
        paste {input.candidateIndel_one_ext} {input.candidateIndel_one_jac} > {output.candidateIndel_one}
        """
