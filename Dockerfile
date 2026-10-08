FROM python:3.11-slim AS base

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsdl1.2-dev \
    ffmpeg && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/app

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

FROM base AS final

COPY . .

EXPOSE 5000

CMD ["python", "-c", "import app; app.app.run(debug=False, host='0.0.0.0', port=5000)"]