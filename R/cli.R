source("R/calculate.R")

#' Main CLI function
#' @export
main <- function() {
  # Parse arguments
  args <- parse_arguments()

  # Setup logging
  # setup_logging(args$verbose)

  # Validate inputs
  # validate_inputs(args)

  # Process
  result <- process_data(args$input, args$output)

  # Exit
  if (result$success) {
    cat("Process completed successfully\n")
    quit(status = 0)
  } else {
    cat("Process failed:", result$error, "\n")
    quit(status = 1)
  }
}

#' Parse command line arguments
parse_arguments <- function() {
  parser <- argparse::ArgumentParser(description = "Calculate duplex metrics")

  parser$add_argument("-i", "--input",
                      required = TRUE,
                      help = "Input file path")
  parser$add_argument("-o", "--output",
                      required = TRUE,
                      help = "Output file path")
  parser$add_argument("-v", "--verbose",
                      action = "store_true",
                      help = "Verbose output")

  parser$parse_args()
}
