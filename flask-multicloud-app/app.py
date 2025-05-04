import os
from flask import Flask, render_template


app = Flask(__name__)

@app.route("/")
def home():
    return  render_template("index.html")

@app.route("/health")
def health():
    return {"status": "healthy"}

@app.route("/cloud")
def cloud():
    return {"cloud": os.environ.get("CLOUD_NAME", "unknown")}

if __name__ == "__main__":
   app.run(debug=True, host="0.0.0.0", port=5000)
