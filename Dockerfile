FROM python:3.12.3-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

WORKDIR /usr/src/app

# COPY requirements.txt ./
RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV POETRY_VERSION=1.8.2
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 -

COPY pyproject.toml poetry.lock ./

RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000","--log-config", "modules/utils/log_conf.yml"]
