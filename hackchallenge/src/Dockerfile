FROM python:3.11.2

RUN mkdir usr/app
WORKDIR usr/app

COPY . . 

RUN pip install -r requirements.txt

CMD python app.py