ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule gunzip_manta_vcf:
    input:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf.gz',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf.gz',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf.gz',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf.gz',
    output:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.vcf',
    conda:
        'envs/manta_env.yml'
    shell:
        """
        gzip -dc {input.diploid} > {output.diploid}
        gzip -dc {input.somatic} > {output.somatic}
        gzip -dc {input.candidate} > {output.candidate}
        gzip -dc {input.candidateIndel} > {output.candidateIndel}
        """
