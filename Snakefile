rule targets:
    input:
        "README.md",
        "docs/proposal.pdf",
        "docs/presentation.html"

rule compile_tex:
    input:
        code="code/compile_tex.sh",
        tex="submission/{filename}.tex",
        pre="submission/preamble.tex",
        bib="submission/prelim.bib"
    output:
        pdf="docs/{filename}.pdf"
    shell:
        """
        bash {input.code} {input.tex} {output.pdf} {wildcards.filename}
        """

rule render_readme:
    input:
        code="code/render.R",
        rmd="README.Rmd"
    output:
        file="README.md"
    params:
        format="github_document"
    script:
        "{input.code}"

rule render_slides:
    input:
        code="code/render.R",
        rmd="submission/presentation.Rmd"
    output:
        file="docs/presentation.html"
    params:
        format="xaringan::moon_reader"
    script:
        "{input.code}"

rule texclean:
    shell:
        "rm -f *.out *.log *.aux *.bbl *.blg *.synctex.gz *.fls *.flx *.fdb_latexmk"
