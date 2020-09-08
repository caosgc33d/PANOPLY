task panoply_normalize_ms_data_report {
  File tarball
  String label
  String type
  String tmpDir

  Int? memory
  Int? disk_space
  Int? num_threads

  command {
    set -euo pipefail
    Rscript /home/pgdac/src/rmd-normalize.r ${tarball} ${label} ${type} ${tmpDir}
  }

  output {
    File report = "norm_" + label + ".html"
  }

  runtime {
    docker : "broadcptacdev/panoply_normalize_ms_data_report:latest"
    memory : select_first ([memory, 8]) + "GB"
    disks : "local-disk " + select_first ([disk_space, 20]) + " SSD"
    cpu : select_first ([num_threads, 1]) + ""
  }

  meta {
    author : "Karsten Krug"
    email : "karsten@broadinstitute.org"
  }
}

workflow panoply_normalize_ms_data_report_workflow {
	call panoply_normalize_ms_data_report
}