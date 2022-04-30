
FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04

ENV TZ=America/Denver \
    DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get install --no-install-recommends -y python3.9 \
                    python3-pip \
                    python3-setuptools \
                    python3-distutils && \
    apt-get install ffmpeg libsm6 libxext6  -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN python3.9 -m pip install --no-cache-dir --upgrade pip setuptools wheel

RUN python3.9 -m pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 80

CMD ["python3.9","app.py"]

