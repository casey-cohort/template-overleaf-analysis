# Format all numeric columns with commas and handle decimals appropriately,
# and to also include character variables
texify <- function(var_name, var_value, digits = 2) {
  # Convert var_name to valid LaTeX command name (no underscores)
  latex_name <- gsub("_", "", var_name)

  # handle numeric values
  if (is.numeric(var_value) && length(var_value) == 1 && !is.na(var_value)) {
    # check if the number is an integer (no decimal part)
    is_integer_like <- (var_value %% 1 == 0)

    if (is_integer_like) {
      # for integers, just add commas without decimal places
      formatted_value <- format(
        var_value,
        big.mark = ",",
        scientific = FALSE,
        nsmall = 0
      )
    } else {
      # for decimals, round to two decimal places
      rounded_value <- round(var_value, digits)
      formatted_value <- format(
        rounded_value,
        big.mark = ",",
        scientific = FALSE,
        nsmall = digits
      )
    }

    paste0("\\newcommand{\\", latex_name, "}{", trimws(formatted_value), "}")
  } else if (
    is.character(var_value) && length(var_value) == 1 && !is.na(var_value)
  ) {
    # handle character values
    # Escape % for LaTeX
    escaped_value <- gsub("%", "\\\\%", var_value)
    # Use brackets [] for CIs instead of parentheses ()
    escaped_value <- gsub("\\(([^)]+)\\)", "[\\1]", escaped_value)
    paste0("\\newcommand{\\", latex_name, "}{", escaped_value, "}")
  } else {
    NULL
  }
}

# Write a tex file to be synced to manuscript directory
write_tex_vars <- function(l, path, digits = 2){
  stopifnot(is.list(l))
  stopifnot(!is.null(names(l)))
  stopifnot(is.character(path) && length(path) == 1)
  stopifnot(is.numeric(digits) && length(digits) == 1)
  lines <- lapply(names(l), \(.x) texify(.x, l[[.x]], digits))
  # texify() returns NULL for values it can't format (non-scalar, NA, etc.)
  unformattable <- names(l)[vapply(lines, is.null, logical(1))]
  if (length(unformattable)) {
    stop(
      "write_tex_vars: could not format these values (must be a single ",
      "non-NA numeric or character): ",
      paste(unformattable, collapse = ", ")
    )
  }
  writeLines(unlist(lines), path)
}

# round DOWN to the nearest `by` -- for "more than X" phrasing (true value sits
# just above the stated round number)
more_than <- function(x, by) {
  floor(x / by) * by
}

# round UP to the nearest `by` -- for "nearly X" phrasing (true value sits
# just below the stated round number)
nearly <- function(x, by) {
  ceiling(x / by) * by
}