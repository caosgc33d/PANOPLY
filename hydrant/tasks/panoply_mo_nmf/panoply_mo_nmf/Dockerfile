FROM broadcptacdev/pgdac_mo_nmf:15

LABEL maintainer="karsten@broadinstitute.org"
LABEL description="Docker for PANOPLY's multi-omic NMF clustering."

RUN R -e "pacman::p_install('pals')"

ENV wd /home/pgdac/
COPY . $wd
