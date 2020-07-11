rule targets:
    input:
        "README.md",
        "docs/proposal.pdf"

rule compile_tex:
    input:
        code="code/compile_tex.sh",
        tex="submission/{filename}.tex",
        pre="preamble.tex",
        bib="prelim.bib"
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

rule texclean:
    shell:
        "rm -f *.out *.log *.aux *.bbl *.blg *.synctex.gz *.fls *.flx *.fdb_latexmk"
