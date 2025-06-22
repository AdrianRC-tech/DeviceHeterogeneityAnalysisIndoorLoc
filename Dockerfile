#
# Docker container for running the Jupyter Notebook environment.
#
# Build:
#   docker image build -t ml4i2024 .
#
# Run:
#
#   docker run -it -v .:/app ml4i2024 bash
#
#     This will start the container with a bash shell in the terminal, allowing to execute Python scripts.
# 
#   docker run -p 8888:8888 -v .:/app ml4i2024
#
#     This will start the container with a Jupyter Notebook server listening on your local port 8888.
#     A link will be shown in the terminal. Open the link in your browser to access the Jupyter Notebook environment.
#

FROM python:3.10.16-slim-bookworm

RUN pip3 install --upgrade pip \
  && pip3 install pandas \
  && pip3 install numpy \
  && pip3 install scikit-learn==1.6.0 \
  && pip3 install statsmodels==0.14.4 \
  && pip3 install matplotlib==3.10.0 \
  && pip3 install jupyter==1.0.0 \
  && pip3 install tensorflow==2.18.0 \
  && pip3 install torch==2.5.1 torchvision==0.20.1 --index-url https://download.pytorch.org/whl/cpu \
  && rm -Rf /root/.cache/pip

RUN apt-get update \
  && apt-get install -y curl \
  && apt-get install -y --no-install-recommends git \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

WORKDIR /app

CMD ["jupyter", "notebook", "--notebook-dir=/app", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]