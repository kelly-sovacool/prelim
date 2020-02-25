rule targets:
    input:
        "README.md",
        "docs/abstract.pdf"

rule compile_tex:
    input:
        code="code/compile_tex.sh",
        tex="submission/{name}.tex",
        pre="preamble.tex",
        bib="prelim.bib"
    output:
        pdf="docs/{name}.pdf"
    shell:
        """
        ./{input.code} {input.tex} {output.pdf} {wildcards.name}
        """

rule render_readme:
    input:
        code="code/render.R",
        rmd="README.Rmd"
    output:
        file="README.md",
        html=temp("README.html")
    params:
        format="github_document"
    script:
        "{input.code}"

rule texclean:
    shell:
        "rm -f *.out *.log *.aux *.bbl *.blg *.synctex.gz *.fls *.flx *.fdb_latexmk"
