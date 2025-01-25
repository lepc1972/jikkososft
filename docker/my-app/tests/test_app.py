import pytest
from app.app import app

@pytest.fixture
def client():
    """Crea un cliente de prueba para la aplicación Flask"""
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_index_route(client):
    """Prueba que la ruta '/' devuelva un mensaje exitoso"""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, Jikkosoft!" in response.data
