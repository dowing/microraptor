ALL.extend([expand(MUTECT_DIR + '{tumor}_{normal}.allPass.vcf',
                  zip,
                  tumor = TUMORS,
                  normal = NORMALS)])
                    
rule all_pass:
    input:
        MUTECT_DIR + '{tumor}_{normal}.twicefiltered.vcf.gz'
    output:
        MUTECT_DIR + '{tumor}_{normal}.allPass.vcf'
    shell:
        """
        gzip -dc {input} | awk '/^#/ {{print $0; next}} $7=="PASS" {{print $0}}' > {output}
        """
