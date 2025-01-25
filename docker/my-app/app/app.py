from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def index():
    db_url = os.getenv("DATABASE_URL", "No database URL set")
    return f"Hello, Jikkosoft! Database URL is: {db_url}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
