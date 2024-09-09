from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['POST'])
def index():
    data = request.form['data']
    return f"Recibido: {data}"

if __name__ == '__main__':
    app.run(debug=True)
