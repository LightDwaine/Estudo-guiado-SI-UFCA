from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"mensagem": "Bem-vindo a API FastOrder!"})

@app.route('/api/status')
def status():
    return jsonify({"status": "operacional", "servico": "Fastorder-Web"})

# Missão 5.1: Rota de soma recebendo parâmetros via Query String
@app.route('/api/soma')
def soma():
    # Pega os parâmetros 'a' e 'b' da URL, definindo 0 como padrão se estiverem vazios
    a = request.args.get('a', 0)
    b = request.args.get('b', 0)

    # Converte para float (já que chegam como String) e realiza a soma
    resultado = float(a) - float(b)

    return jsonify({"resultado": resultado})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)