from flask import Flask
import redis
import os
 
app = Flask(__name__)
 
# "redis" is the hostname we'll use later — Docker will let our containers
# find each other by name, so we don't need a real IP address.
redis_host = os.environ.get("REDIS_HOST", "localhost")
r = redis.Redis(host=redis_host, port=6379, decode_responses=True)
 
@app.route("/")
def home():
    count = r.incr("visits")   # increments a counter stored in Redis and returns the new value
    return f"This page has been visited {count} times.\n"
 
@app.route("/health")
def health():
    return "OK", 200
 
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
