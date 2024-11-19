# # python3.11のイメージをダウンロード
# FROM python:3.11-buster

# # pythonの出力表示をDocker用に調整
# ENV PYTHONUNBUFFERED=1

# WORKDIR /src

# # pipを使ってpoetryをインストール
# RUN pip install poetry

# # poetryの定義ファイルをコピー(存在する場合)
# COPY pyproject.toml* poetry.lock* ./

# # poetryでライブラリをインストール(pyproject.tomlが既にある場合)
# RUN poetry config virtualenvs.in-project true

# RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# # uvicornのサーバーを立ち上げる
# ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]

# python3.11のイメージをダウンロード
FROM python:3.11-buster

# pythonの出力表示をDocker用に調整
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# pipを使ってpoetryをインストール
RUN pip install poetry

# poetryの定義ファイルをコピー (pyproject.tomlが存在する場合)
COPY pyproject.toml ./

# poetry.lockを作成
RUN if [ -f pyproject.toml ]; then poetry lock; fi

# poetryでライブラリをインストール
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# uvicornのサーバーを立ち上げる
ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]
