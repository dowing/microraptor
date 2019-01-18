ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule snpeff_top_effect_manta:
    input:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.vcf',

    output:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.top_effect.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.top_effect.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.top_effect.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.top_effect.vcf',
    conda:
        'envs/snpeff_env.yml'
    params:
        script = config['input_dir']['snpeff'] + 'vcfAnnFirst.py'
    shell:
        """
        cat {input.diploid} | python2 {params.script} > {output.diploid}
        cat {input.somatic} | python2 {params.script} > {output.somatic}
        cat {input.candidate} | python2 {params.script} > {output.candidate}
        cat {input.candidateIndel} | python2 {params.script} > {output.candidateIndel}
        """
