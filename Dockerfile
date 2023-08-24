FROM python

WORKDIR .
ADD ./model.tar.gz ./home/

RUN apt-get update && apt-get install -y sudo
RUN chmod +w /etc/sudoers
RUN echo 'irteam ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN chmod -w /etc/sudoers
RUN sudo apt-get install -y libgl1-mesa-glx
RUN sudo apt-get install -y python3-pip

# Install Miniconda
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
# arm64
RUN wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh -O ~/miniconda.sh
## amd64
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda

ENV PATH="/root/miniconda/bin:${PATH}"

RUN conda install -c conda-forge -y opencv


# Install Packages
RUN pip install --upgrade pip
RUN pip3 install torch torchvision torchaudio
RUN pip install ultralytics
RUN pip install gradio