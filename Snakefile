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
