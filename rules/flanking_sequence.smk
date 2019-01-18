ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule flanking_sequence:
    input:
        MUTECT_DIR + '{tumor}_{normal}.allPass.vcf'
    output:
        flanking = MUTECT_DIR + '{tumor}_{normal}.allPass.annotated.flanking_sequence.vcf'
    conda:
        'envs/vcftools_env.yml'
    params:
        fasta = config['input_dir']['ref'] + 'ucsc.hg19.fasta',
        length = config['fill-fs']['length']
    shell:
        """
        fill-fs \
        --refseq {params.fasta} \
        --length {params.length} \
        {input} > {output}
        """
