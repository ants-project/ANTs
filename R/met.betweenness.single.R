# Copyright (C) 2018  Sebastian Sosa, Ivan Puga-Gonzalez, Hu Feng He,Peng Zhang, Xiaohua Xie, Cédric Sueur
#
# This file is part of Animal Network Toolkit (ANT).
#
# ANT is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# ANT is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#' @title Betweenness centrality
#' @description Compute node betweenness
#' @keywords internal

met.betweenness.single <- function(m, binary = T, shortest.weight = F, normalization = T, sym = T, out = T, df = NULL, dfid = NULL) {
  name <- colnames(m)
  if (binary) {
    m <- mat_filter(m, 1, 1)
    colnames(m) <- name
    rownames(m) <- name
  }
  if (normalization) {
    avg_strength <- mean(m)
    m <- m / avg_strength
  }
  if (shortest.weight) {
    # opshal method
    m <- 1 / m
    m[is.infinite(m)] <- 0
  }
  if (sym) {
    m <- m + t(m)
  }
  else {
    if (out == F) {
      m <- t(m)
    }
  }
  if (is.null(df)) {
    result <- metric_node_betweeness(m)
    attr(result, "names") <- colnames(m)
    return(result)
  }
  else {
    if (!is.null(dfid)) {
      if (is.null(colnames(m))) {
        stop("Argument m doesn't have column names")
      }
      col.id <- df.col.findId(df, dfid)
      df <- df[match(colnames(m), df[, col.id]), ]
    }
    if (is.data.frame(df) == F) {
      stop("Argument df must be a data frame")
    }
    result <- metric_node_betweeness(m)
  }

  df[, ncol(df) + 1] <- result
  return(df)
}