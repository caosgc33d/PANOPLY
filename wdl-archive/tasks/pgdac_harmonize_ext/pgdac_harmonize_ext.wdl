task pgdac_harmonize_ext {
  File normData
  File rnaExpr
  File cnaExpr
  File exptDesign
  String analysisDir
  String type
  String? subType
  File? params
  String codeDir = "/prot/proteomics/Projects/PGDAC/src"
  String dataDir = "/prot/proteomics/Projects/PGDAC/data"
  String outFile = "pgdac_harmonize-output.tar"

  Int? memory
  Int? disk_space
  Int? num_threads
  Int? num_preemptions


  command {
    set -euo pipefail
    /prot/proteomics/Projects/PGDAC/src/run-pipeline.sh harmonize -f ${normData} -t ${type} -c ${codeDir} -d ${dataDir} -r ${analysisDir} -e ${exptDesign} -rna ${rnaExpr} -cna ${cnaExpr} -o ${outFile} ${"-m " + subType} ${"-p " + params}
  }

  output {
    File outputs = "${outFile}"
  }

  runtime {
    docker : "broadcptac/pgdac_main:2"
    memory : select_first ([memory, 12]) + "GB"
    disks : "local-disk " + select_first ([disk_space, 20]) + " SSD"
    cpu : select_first ([num_threads, 1]) + ""
    preemptible : select_first ([num_preemptions, 0])
  }

  meta {
    author : "D. R. Mani"
    email : "manidr@broadinstitute.org"
  }
}

workflow pgdac_harmonize_ext_workflow {
	call pgdac_harmonize_ext
}