FROM python

WORKDIR .
ADD ./model.tar.gz ./home/


RUN apt-get update && apt-get install -y sudo
RUN chmod +w /etc/sudoers
RUN echo 'irteam ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN chmod -w /etc/sudoers
RUN sudo apt-get install -y libgl1-mesa-glx
RUN sudo apt-get install -y python3-pip

RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
RUN bash Anaconda3-2023.07-2-Linux-x86_64.sh -b -p $HOME/anaconda
RUN source ~/anaconda/bin/activate
RUN conda install opencv

RUN apt-get install -y libgl1-mesa-glx

RUN apt-get install -y vim

RUN pip install --upgrade pip
RUN pip3 install torch torchvision torchaudio
RUN pip install ultralytics
RUN pip install gradio
RUN pip install opencv-python