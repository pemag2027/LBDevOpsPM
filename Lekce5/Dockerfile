FROM python:3.9-slim
WORKDIR /Lekce5/app
COPY Lekce5/app/calculator.py .
COPY Lekce5/app/test_multiply.py .
RUN python -m "unittest" "Lekce5/app/test_multiply.py" -v
CMD ["python", "Lekce5/app/calculator.py"]

