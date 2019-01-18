ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff_stats.html',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff_stats.html',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff_stats.html',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff_stats.html',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule snpeff_annotation_manta:
    input:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf',
    output:
        diploid_stats = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff_stats.html',
        diploid_vcf = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.vcf',
        somatic_stats = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff_stats.html',
        somatic_vcf = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.vcf',
        candidate_stats = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff_stats.html',
        candidate_vcf = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.vcf',
        candidateIndel_stats = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff_stats.html',
        candidateIndel_vcf = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.vcf'
    conda:
        'envs/snpeff_env.yml'
    params:
        org = ORG
    shell:
        """
        snpEff eff \
        -Xmx4g \
        -v \
        -stats {output.diploid_stats} \
        {params.org} \
        {input.diploid} > {output.diploid_vcf}
        
        snpEff eff \
        -Xmx4g \
        -v \
        -stats {output.somatic_stats} \
        {params.org} \
        {input.somatic} > {output.somatic_vcf}
        
        snpEff eff \
        -Xmx4g \
        -v \
        -stats {output.candidate_stats} \
        {params.org} \
        {input.candidate} > {output.candidate_vcf}
        
        snpEff eff \
        -Xmx4g \
        -v \
        -stats {output.candidateIndel_stats} \
        {params.org} \
        {input.candidateIndel} > {output.candidateIndel_vcf}
        """
