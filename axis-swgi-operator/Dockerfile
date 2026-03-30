FROM registry.access.redhat.com/ubi9/python-311:latest

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /opt/app-root/src

COPY axis-swgi-operator/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY axis-swgi-operator /opt/app-root/src/axis-swgi-operator

USER 1001

ENTRYPOINT ["kopf", "run", "/opt/app-root/src/axis-swgi-operator/controller/main.py"]
