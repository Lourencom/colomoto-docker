FROM colomoto/colomoto-docker:next

# Switch to root to install additional software
USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-all-dev \
    python3-dev \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O modrev.zip https://filipegouveia.github.io/ModRev/ModRev-1.3.2.zip \
    && unzip modrev.zip -d /opt/ \
    && rm modrev.zip \
    && ls -al /opt/

RUN cd /opt/ModRev/ && \
   make config && make


# Copy your custom fat .jars into the image
COPY ./GINSIM-fat.jar /opt/conda/opt/GINsim.jar
RUN chmod a+r /opt/conda/opt/GINsim.jar

# Any additional installation commands for modrev and its dependencies
RUN echo "Installation commands for modrev"

COPY ./pymodrev /opt/pymodrev

ARG NB_USER=user
COPY --chown=$NB_USER:$NB_USER ./modrev_tutorial.ipynb /notebook/tutorials/ModRev/

# Install the pymodrev package from the local directory
RUN pip install /opt/pymodrev

# switch back to user mode
USER user

# Any additional setup steps for your tool, such as environment variables
