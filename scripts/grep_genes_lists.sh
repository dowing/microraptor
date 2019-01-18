#script to select out genes from genes_list.txt in the varians and sv.

GENE_LIST='/ccmb/BioinfCore/ActiveProjects/LSA_Buttitta_buttitta_CU4_cjsifuen_NR/analysis_09_14/gene_lists.txt'

###########
#Process variants files
###########
VAR_DIR='/ccmb/BioinfCore/ActiveProjects/LSA_Buttitta_buttitta_CU4_cjsifuen_NR/analysis_09_14/processed/variants'
cd ${VAR_DIR}

#cut columns, grep genes in gene_lists.txt files and save to new file 
for i in *.variants.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .variants.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.variants.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.variants.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.variants.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .variants.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.variants.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.variants.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

##########
#Process SV/Indel files files
##########
SV_DIR='/ccmb/BioinfCore/ActiveProjects/LSA_Buttitta_buttitta_CU4_cjsifuen_NR/analysis_09_14/processed/SV'
cd ${SV_DIR}

for i in *.diploidSV.snpeff.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .diploidSV.snpeff.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.diploidSV.snpeff.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.diploidSV.snpeff.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.somaticSV.snpeff.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .somaticSV.snpeff.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.somaticSV.snpeff.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.somaticSV.snpeff.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.candidateSV.snpeff.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .candidateSV.snpeff.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.candidateSV.snpeff.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.candidateSV.snpeff.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.candidateSmallIndels.snpeff.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .candidateSmallIndels.snpeff.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.candidateSmallIndels.snpeff.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.candidateSmallIndels.snpeff.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.tumorSV.snpeff.top_effect.annotated.tsv; 
    do BASE=$(basename ${i} .tumorSV.snpeff.top_effect.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.tumorSV.snpeff.top_effect.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.tumorSV.snpeff.top_effect.annotated.gene_lists.tsv;
    rm ${i}.tmp
done




for i in *.diploidSV.snpeff.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .diploidSV.snpeff.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.diploidSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.diploidSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.somaticSV.snpeff.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .somaticSV.snpeff.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.somaticSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.somaticSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.candidateSV.snpeff.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .candidateSV.snpeff.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.candidateSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.candidateSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.candidateSmallIndels.snpeff.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .candidateSmallIndels.snpeff.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.candidateSmallIndels.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.candidateSmallIndels.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done

for i in *.tumorSV.snpeff.one_eff_per_line.annotated.tsv; 
    do BASE=$(basename ${i} .tumorSV.snpeff.one_eff_per_line.annotated.tsv);
    cat ${i} | cut -f1-9,12,15- > ${i}.tmp;
    sed "1s/ANN\[0\]\.//g" ${i}.tmp > ${i};
    head -n 1 ${i} > ${BASE}.tumorSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    grep -f ${GENE_LIST} -wi ${i} >> ${BASE}.tumorSV.snpeff.one_eff_per_line.annotated.gene_lists.tsv;
    rm ${i}.tmp
done
