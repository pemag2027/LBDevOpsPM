FROM python:3.9-slim
WORKDIR /Lekce5/app
COPY Lekce5/app/calculator.py .
COPY Lekce5/app/test_multiply.py .
RUN ls -la
#RUN python -m app/unittest test_multiply.py -v
CMD ["python", "calculator.py"]

