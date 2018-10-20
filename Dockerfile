FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	libboost-all-dev \
	libgsl0-dev \
	libeigen3-dev \
	software-properties-common \
	curl \
	cmake \
    && rm -rf /var/lib/apt/lists/*
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py

COPY nmslib/similarity_search /similarity_search
RUN cd similarity_search/ && cmake . && make

COPY requirements.txt /requirements.txt
# RUN python3 -m pip install 'pip==9.0.3'
RUN python3 -m pip install -r requirements.txt

COPY build.py /build.py
COPY text_to_uri.py /text_to_uri.py
COPY server.py /server.py

CMD ["python3", "/server.py"]
