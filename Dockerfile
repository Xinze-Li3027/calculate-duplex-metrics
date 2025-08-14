FROM rocker/r-ver:4.3.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY DESCRIPTION .
COPY renv.lock .
COPY .Rprofile .

# Install renv and restore packages
RUN R -e "install.packages('renv')" && \
    R -e "renv::restore()"

# Copy application code
COPY . .

# Install the package
RUN R -e "devtools::install('.', dependencies = FALSE)"

# Make CLI executable
RUN chmod +x inst/cli/main.R

# Set entrypoint
ENTRYPOINT ["Rscript", "inst/cli/main.R"]
