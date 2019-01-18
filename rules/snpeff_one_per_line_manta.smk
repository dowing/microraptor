ALL.extend([expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),
            expand(MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS),])
                    
rule snpeff_one_per_line_manta:
    input:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.vcf',

    output:
        diploid = MANTA_DIR + '{tumor}_{normal}_config/results/variants/diploidSV.snpeff.one_eff_per_line.vcf',
        somatic = MANTA_DIR + '{tumor}_{normal}_config/results/variants/somaticSV.snpeff.one_eff_per_line.vcf',
        candidate = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSV.snpeff.one_eff_per_line.vcf',
        candidateIndel = MANTA_DIR + '{tumor}_{normal}_config/results/variants/candidateSmallIndels.snpeff.one_eff_per_line.vcf',
    conda:
        'envs/snpeff_env.yml'
    params:
        script = config['input_dir']['snpeff'] + 'vcfEffOnePerLine.pl'
    shell:
        """
        cat {input.diploid} | perl {params.script} > {output.diploid}
        cat {input.somatic} | perl {params.script} > {output.somatic}
        cat {input.candidate} | perl {params.script} > {output.candidate}
        cat {input.candidateIndel} | perl {params.script} > {output.candidateIndel}
        """
