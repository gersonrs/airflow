FROM apache/airflow:3.3.0
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  # openjdk-17-jre-headless \
  build-essential \
  libopenmpi-dev \
  librdkafka-dev \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow
# ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
COPY requirements.txt /
RUN uv pip install "apache-airflow[google,apache-spark,apache-kafka,apache-pinot,apache-flink,cncf-kubernetes,celery,git,odbc,mysql,postgres,redis,trino,common-ai,http,grpc,keycloak,jdbc,papermill,amazon]==${AIRFLOW_VERSION}" \
  --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-3.3.0/constraints-3.12.txt" -r /requirements.txt
