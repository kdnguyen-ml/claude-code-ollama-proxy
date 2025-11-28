FROM python:3.12-slim

WORKDIR /claude-code-proxy

# Copy package specifications
COPY ./pyproject.toml ./pyproject.toml
COPY ./uv.lock ./uv.lock

# Install uv and project dependencies
RUN pip install --upgrade uv && uv sync --locked

# Copy project code to current directory
COPY ./server.py ./server.py

# Start the proxy
ARG CLAUDE_CODE_PROXY_PORT
ENV CLAUDE_CODE_PROXY_PORT=${CLAUDE_CODE_PROXY_PORT}
EXPOSE ${CLAUDE_CODE_PROXY_PORT}
CMD uv run uvicorn server:app --host 0.0.0.0 --port ${CLAUDE_CODE_PROXY_PORT} --reload
