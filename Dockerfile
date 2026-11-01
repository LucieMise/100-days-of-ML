
FROM python:3.12-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Configure uv
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Copy dependency configuration first
COPY pyproject.toml uv.lock ./

# Install dependencies without installing the project yet
RUN uv sync --frozen --no-install-project

# Copy application code
COPY . .

# Install the project
RUN uv sync --locked

# Activate the virtual environment
ENV PATH="/app/.venv/bin:$PATH"

# Default command
CMD ["python", "main.py"]
