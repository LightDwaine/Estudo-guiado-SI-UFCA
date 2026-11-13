import pytest
from app import app

# Cria um cliente de teste falso para não precisarmos subir o servidor real
@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_status_code(client):
    resposta = client.get('/')
    assert resposta.status_code == 200

def test_home_mensagem(client):
    resposta = client.get('/')
    dados = resposta.get_json()
    assert dados['mensagem'] == "Bem-vindo a API FastOrder!"

# Missão 6.1: Crie um teste para a sua rota /api/soma
def test_soma(client):
    # Faz a requisição simulada passando os parâmetros
    resposta = client.get('/api/soma?a=10&b=5')
    dados = resposta.get_json()

    # Verifica se o status code é 200
    assert resposta.status_code == 200

    # Verifica se o JSON retornado tem o resultado correto (no guia é 15.0)
    assert dados['resultado'] == 15.0