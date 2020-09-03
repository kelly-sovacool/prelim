rule targets:
    input:
        "README.md",
        "docs/abstract.pdf",
        "docs/proposal.pdf"

rule compile_proposal:
    input:
        code="code/compile_tex.sh",
        tex="submission/proposal.tex",
        pre="submission/preamble.tex",
        bib="submission/prelim.bib",
        aims="submission/aims.tex"
    output:
        pdf="docs/proposal.pdf"
    shell:
        """
        bash {input.code} {input.tex} {output.pdf} proposal
        """

rule compile_abstract:
    input:
        code="code/compile_tex.sh",
        tex="submission/abstract.tex",
        pre="submission/preamble.tex",
        aims='submission/aims.tex'
    output:
        pdf="docs/abstract.pdf"
    shell:
        """
        bash {input.code} {input.tex} {output.pdf} abstract
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
        "code/render.R"

rule texclean:
    shell:
        "rm -f *.out *.log *.aux *.bbl *.blg *.synctex.gz *.fls *.flx *.fdb_latexmk"
