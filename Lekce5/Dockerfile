FROM python:3.9-slim
WORKDIR /app
COPY calculator.py .
COPY test_multiply.py .
RUN python -m unittest test_multiply.py -v
CMD ["python", "calculator.py"]

