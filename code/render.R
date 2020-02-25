format <- snakemake@params[["format"]]
input_file <- here::here(snakemake@input[["rmd"]])
output_file <- here::here(snakemake@output[["file"]])
# TODO: dictionary mapping input file extensions to format strings
rmarkdown::render(input_file,
  output_format = format,
  output_file = output_file
)
