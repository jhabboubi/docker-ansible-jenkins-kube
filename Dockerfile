FROM python:latest

COPY . /usr/src/app/

WORKDIR /usr/src/app/

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "web.py"]
