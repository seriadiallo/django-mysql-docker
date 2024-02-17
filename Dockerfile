# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.11-slim

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN apt update &&  apt install -y default-libmysqlclient-dev build-essential

# RUN apt update &&  apt install -y  build-essential
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/src/app
RUN mkdir /usr/src/app/staticfiles

# dossier de travail
WORKDIR /usr/src/app/

# Install pip requirements
COPY requirements.txt .

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /usr/src/app/
USER appuser



RUN pip install -r requirements.txt


COPY . /usr/src/app/
