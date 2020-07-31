rule targets:
    input:
        "README.md",
        "docs/proposal.pdf",
        "docs/presentation.html"

rule compile_proposal:
    input:
        code="code/compile_tex.sh",
        tex="submission/proposal.tex",
        pre="submission/preamble.tex",
        bib="submission/prelim.bib",
        abs="submission/abstract.tex"
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
        pre="submission/preamble.tex"
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

rule render_slides:
    input:
        code="code/render.R",
        rmd="submission/presentation.Rmd"
    output:
        file="submission/presentation.html"
        #extras=directory("submission/presentation_files")
    params:
        format="xaringan::moon_reader"
    script:
        "code/render.R"

rule summon_remark:
    output:
        "docs/libs/remark-latest.min.js"
    shell:
        """
        R -e 'xaringan::summon_remark(to = "docs/libs/")'
        """

rule clean_xaringan:
    input:
        files=rules.render_slides.output,
        js=rules.summon_remark.output
    output:
        "docs/presentation.html"
        #directory("docs/presentation_files")
    shell:
        """
        for f in {input.files}; do
            mv $f docs/
        done
        rm -r submission/libs
        """

rule texclean:
    shell:
        "rm -f *.out *.log *.aux *.bbl *.blg *.synctex.gz *.fls *.flx *.fdb_latexmk"
