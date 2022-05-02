FROM python:3.10

RUN useradd corp_bot

WORKDIR /home/corp_bot/bots

RUN pip install --upgrade pip

RUN pip install versiontools

RUN pip install python-socketio
RUN pip install discord

COPY . .

RUN chown -R corp_bot:corp_bot ./

USER corp_bot