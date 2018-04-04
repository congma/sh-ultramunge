FROM ragnaroek/kcov:v33
ADD sh-ultramunge.sh Makefile /sh-ultramunge/
ADD tests /sh-ultramunge/tests
WORKDIR /sh-ultramunge
ENTRYPOINT ["/bin/sh", "-c"]
